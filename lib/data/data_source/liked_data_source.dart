import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class LikedDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveProductAsLiked(
    String uid,
    Map<String, dynamic> productData,
  ) async {
    try {
      await firestore
          .collection(uid)
          .doc("liked_products")
          .collection("products")
          .doc(productData["productName"])
          .set(productData);
    } catch (e) {
      throw Exception("[error] failed to save product as liked : $e");
    }
  }

  Future<void> deleteProductInFirestore(String uid, String productName) async {
    try {
      await firestore
          .collection(uid)
          .doc("liked_products")
          .collection("products")
          .doc(productName)
          .delete();
    } catch (e) {
      throw Exception("[error] failed to delete liked product : $e");
    }
  }

  Future<List<Map<String, dynamic>>> getLikedProducts(String uid) async {
    try {
      final docSnapshot = await firestore
          .collection(uid)
          .doc("liked_products")
          .collection("products")
          .get();
      if (docSnapshot.docs.isNotEmpty) {
        return docSnapshot.docs.map((doc) => doc.data()).toList();
      } else {
        debugPrint("[empty] comparison text is empty");
        return [];
      }
    } catch (e) {
      throw Exception("[error] failed to fetch liked products : $e");
    }
  }
}
