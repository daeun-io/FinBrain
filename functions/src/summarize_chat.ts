import { onSchedule } from "firebase-functions/v2/scheduler";
import * as admin from "firebase-admin";
import { GoogleGenAI } from "@google/genai";
import { decryptText, encryptText } from "./aes_helper";

admin.initializeApp();

const db = admin.firestore();

export const summarizeAndArchiveChat = onSchedule(
  {
    schedule: "0 3 * * *",
    timeZone: "Asia/Seoul",
    secrets: ["GEMINI_API_KEY", "AES_KEY"],
  },
  async () => {

    const ai = new GoogleGenAI({ apiKey: process.env.GEMINI_API_KEY });

    // 1. 모든 chat_history 컬렉션 가져오기
    const chatHistorySnapshot = await db.collectionGroup("chat_history").get();

    if (chatHistorySnapshot.empty) {
      console.log("⚠️ Firestore에서 chat_history 컬렉션을 찾지 못했거나 문서가 0개입니다. 데이터를 다시 확인해주세요.");
      return;
    }

    // 2. encryptedUid와 productNameOrCd를 기준으로 문서 그룹화
    interface ChatGroup {
      encryptedUid: string;
      productNameOrCd: string;
      docs: admin.firestore.QueryDocumentSnapshot[];
    }

    const groupedChats = new Map<string, ChatGroup>();

    chatHistorySnapshot.docs.forEach((doc) => {
      const pathSegments = doc.ref.path.split("/");

      if (
        pathSegments.length >= 8 &&
        pathSegments[0] === "users" &&
        pathSegments[2] === "activities" &&
        pathSegments[3] === "ai_conversation" &&
        pathSegments[4] === "products" &&
        pathSegments[6] === "chat_history"
      ) {
        const encryptedUid = pathSegments[1];
        const productNameOrCd = pathSegments[5];
        const key = `${encryptedUid}_${productNameOrCd}`;

        if (!groupedChats.has(key)) {
          groupedChats.set(key, { encryptedUid, productNameOrCd, docs: [] });
        }
        groupedChats.get(key)?.docs.push(doc);
      }
    });

    // 3. 그룹별 요약 생성 및 트랜잭션(Batch) 처리
    let batch = db.batch();
    let operationCount = 0;
    let commitCount = 0;

    for (const group of groupedChats.values()) {
      const { encryptedUid, productNameOrCd, docs } = group;

      const chatTexts = docs
        .map((d) => {
          const data = d.data();
          const request = data.request ?
            decryptText(data.request) :
            "질문 없음";
          const response = data.response ?
            decryptText(data.response) :
            "답변 없음";
          return `User: ${request}\nAI: ${response}`;
        })
        .join("\n\n");

      let summaryText = "";
      try {
        const response = await ai.models.generateContent({
          model: "gemini-3.5-flash",
          contents: `다음은 사용자와 AI가 나눈 대화 내역을 이 분석하여 사용자의 질문과 AI의 핵심 답변 위주로 가독성 좋게 요약해 주세요. 사족은 제외하고 내용만 작성해주세요\n\n[대화 내역]\n${chatTexts}`,
        });

        summaryText = response.text || "요약 본문이 비어 있습니다.";
      } catch (error) {
        console.error(`❌ ${productNameOrCd} 요약 중 API 오류 발생:`, error);
        summaryText = "대화 요약 생성에 실패했습니다. (Gemini API 오류)";
      }

      const sourceProductRef = db
        .collection("users")
        .doc(encryptedUid)
        .collection("activities")
        .doc("ai_conversation")
        .collection("products")
        .doc(productNameOrCd);

      const productRef = db
        .collection("users")
        .doc(encryptedUid)
        .collection("activities")
        .doc("ai_summary")
        .collection("products")
        .doc(productNameOrCd);

      const summaryRef = productRef.collection("chat_summary").doc();

      const sourceProductDoc = await sourceProductRef.get();
      let category = "";
      if (sourceProductDoc.exists && sourceProductDoc.data()?.category) {
        category = sourceProductDoc.data()?.category;
      } else {
        category = docs[0].data().category || "";
      }

      let prdtNm = "";
      if (sourceProductDoc.exists && sourceProductDoc.data()?.prdt_name) {
        prdtNm = sourceProductDoc.data()?.prdt_name;
      } else {
        prdtNm = docs[0].data().prdt_name || "";
      }

      batch.set(productRef, {
        category: category,
        prdt_name: prdtNm,
        is_pinned: false,
      }, { merge: true });

      batch.set(summaryRef, {
        summary: encryptText(summaryText),
        created_at: admin.firestore.FieldValue.serverTimestamp(),
      });

      operationCount += 2;

      for (const doc of docs) {
        batch.delete(doc.ref);
        operationCount++;

        if (operationCount >= 490) {
          await batch.commit();
          commitCount++;
          batch = db.batch();
          operationCount = 0;
        }
      }

      batch.delete(sourceProductRef);
      operationCount++;

      if (operationCount >= 490) {
        await batch.commit();
        commitCount++;
        batch = db.batch();
        operationCount = 0;
      }
    }

    if (operationCount > 0) {
      await batch.commit();
      commitCount++;
    }

    console.log(`✅ 성공적으로 요약 및 삭제를 완료했습니다. (총 ${commitCount}회 Batch 커밋)`);
  }
);
