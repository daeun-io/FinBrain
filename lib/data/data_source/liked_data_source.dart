import 'package:cloud_firestore/cloud_firestore.dart';

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
      print("Error saving liked product: $e");
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
      print("Error deleting liked product: $e");
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
        return [];
      }
    } catch (e) {
      print("Error fetching liked product: $e");
      return [];
    }
  }
}
