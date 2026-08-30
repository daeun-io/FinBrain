import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class LikedDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // 금융 상품 관심 리스트에 저장하기
  // Save given financial product in liked list
  Future<void> saveProductAsLiked(
    String uid,
    Map<String, dynamic> productData,
  ) async {
    try {
      await firestore
          .collection("users")
          .doc(uid)
          .collection("activities")
          .doc("liked_products")
          .collection("products")
          .doc(
            (productData["category"] == "ProductCategory.isaMp")
                ? productData["productName"]
                : productData["productCode"],
          )
          .set(productData);
    } catch (e) {
      throw Exception("[error] failed to save product as liked : $e");
    }
  }

  // 금융 상품 관심 리스트에서 삭제하기
  // Delete given financial product in liked list
  Future<void> deleteProductInFirestore(String uid, String nmOrCd) async {
    try {
      await firestore
          .collection("users")
          .doc(uid)
          .collection("activities")
          .doc("liked_products")
          .collection("products")
          .doc(nmOrCd)
          .delete();
    } catch (e) {
      throw Exception("[error] failed to delete liked product : $e");
    }
  }

  // 관심 상품 목록 리스트 불러오기
  // get all financial products in liked list
  Future<List<Map<String, dynamic>>> getLikedProducts(String uid) async {
    try {
      final docSnapshot = await firestore
          .collection("users")
          .doc(uid)
          .collection("activities")
          .doc("liked_products")
          .collection("products")
          .get();
      if (docSnapshot.docs.isNotEmpty) {
        return docSnapshot.docs.map((doc) => doc.data()).toList();
      } else {
        debugPrint("[empty] no item in liked list");
        return [];
      }
    } catch (e) {
      throw Exception("[error] failed to fetch liked products : $e");
    }
  }
}
