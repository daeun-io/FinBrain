import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as admin from "firebase-admin";
import { encryptText } from "./aes_helper";

admin.initializeApp();

const db = admin.firestore();

export async function deleteUserDocumentTree(docId: string): Promise<void> {
  const userRef = db.collection("users").doc(docId);
  await db.recursiveDelete(userRef);
}

export const deleteAllUserData = onCall(
  {
    region: "asia-northeast3",
    secrets: ["AES_KEY"],
  },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "로그인이 필요합니다.");
    }

    const uid = request.auth.uid;
    const encryptedUid = encryptText(uid);

    await deleteUserDocumentTree(uid);

    if (encryptedUid !== uid) {
      await deleteUserDocumentTree(encryptedUid);
    }

    console.log(`✅ users/${uid} 및 관련 데이터 삭제 완료`);
    return { success: true };
  },
);
