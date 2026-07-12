import { onSchedule } from "firebase-functions/v2/scheduler";
import * as admin from "firebase-admin";
import { GoogleGenAI } from "@google/genai";

admin.initializeApp();

const db = admin.firestore();

export const summarizeAndArchiveChat = onSchedule(
  {
    schedule: "0 3 * * *",
    timeZone: "Asia/Seoul",
    secrets: ["GEMINI_API_KEY"],
  },
  async () => {

    const ai = new GoogleGenAI({ apiKey: process.env.GEMINI_API_KEY });

    // 1. 모든 chat_history 컬렉션 가져오기
    const chatHistorySnapshot = await db.collectionGroup("chat_history").get();

    if (chatHistorySnapshot.empty) {
      console.log("⚠️ Firestore에서 chat_history 컬렉션을 찾지 못했거나 문서가 0개입니다. 데이터를 다시 확인해주세요.");
      return;
    }

    // 2. uid와 product_name을 기준으로 문서 그룹화
    interface ChatGroup {
      uid: string;
      productName: string;
      docs: admin.firestore.QueryDocumentSnapshot[];
    }

    // new Map()은 절대 null이 될 수 없으므로 기존의 null 체크 조건문은 제거했습니다.
    const groupedChats = new Map<string, ChatGroup>();

    chatHistorySnapshot.docs.forEach((doc) => {
      const pathSegments = doc.ref.path.split("/");

      if (
        pathSegments.length >= 6 &&
        pathSegments[1] === "ai_conversation" &&
        pathSegments[2] === "products"
      ) {
        const uid = pathSegments[0];
        const productName = pathSegments[3];
        const key = `${uid}_${productName}`;

        if (!groupedChats.has(key)) {
          groupedChats.set(key, { uid, productName, docs: [] });
        }
        if (groupedChats.get(key) == null) {
          console.error("groupedChats.get(key) is null");
          return;
        }
        // 안전하게 push 하도록 논리 연산자 단순화
        groupedChats.get(key)?.docs.push(doc) ?? [];
      }
    });

    // 3. 그룹별 요약 생성 및 트랜잭션(Batch) 처리
    let batch = db.batch();
    let operationCount = 0;
    let commitCount = 0;

    for (const group of groupedChats.values()) {
      const { uid, productName, docs } = group;

      // 대화 데이터 텍스트 조립 (필드명이 request, response가 맞는지 콘솔과 대조 필수)
      const chatTexts = docs
        .map((d) => {
          const data = d.data();
          const request = data.request || "질문 없음";
          const response = data.response || "답변 없음";
          return `User: ${request}\nAI: ${response}`;
        })
        .join("\n\n");

      let summaryText = "";
      try {
        // 4. Gemini Developer API 호출
        const response = await ai.models.generateContent({
          model: "gemini-3.5-flash",
          contents: `다음은 사용자와 AI가 나눈 대화 내역을 이 분석하여 사용자의 질문과 AI의 핵심 답변 위주로 가독성 좋게 요약해 주세요. 사족은 제외하고 내용만 작성해주세요\n\n[대화 내역]\n${chatTexts}`,
        });

        summaryText = response.text || "요약 본문이 비어 있습니다.";
      } catch (error) {
        console.error(`❌ ${uid} 사용자의 ${productName} 요약 중 API 오류 발생:`, error);
        summaryText = "대화 요약 생성에 실패했습니다. (Gemini API 오류)";
      }

      const sourceProductRef = db.collection(uid).doc("ai_conversation").collection("products").doc(productName);
      // 새 요약 문서 참조 생성
      const productRef = db.collection(uid).doc("ai_summary").collection("products").doc(productName);
      const summaryRef = db
        .collection(uid)
        .doc("ai_summary")
        .collection("products")
        .doc(productName)
        .collection("chat_summary")
        .doc();
      
      const sourceProductDoc = await sourceProductRef.get();
      let category = "";
      if (sourceProductDoc.exists && sourceProductDoc.data()?.category) {
        category = sourceProductDoc.data()?.category;
      } else {
        category = docs[0].data().category || "";
      }

      // 상품 문서 접근을 위한 객체 생성
      batch.set(productRef, {
        category: category,
        is_pinned: false,
      }, {merge: true});
      // 요약 저장
      batch.set(summaryRef, {
        summary: summaryText,
        created_at: admin.firestore.FieldValue.serverTimestamp(),
      });
      
      operationCount += 2;

      // 기존 채팅 히스토리 삭제 (N operations)
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

      // 원본 채팅에 대하 상품 문서 삭제
      batch.delete(sourceProductRef);
        operationCount++;
      
        // Batch 제한(500개) 안전 방어
        if (operationCount >= 490) {
          await batch.commit();
          commitCount++;
          batch = db.batch();
          operationCount = 0;
        }
    }

    // 남은 Batch 작업 커밋
    if (operationCount > 0) {
      await batch.commit();
      commitCount++;
    }

    console.log(`✅ 성공적으로 요약 및 삭제를 완료했습니다. (총 ${commitCount}회 Batch 커밋)`);
  }
);