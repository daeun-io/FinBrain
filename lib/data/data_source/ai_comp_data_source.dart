import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finbrain/product_categories.dart';

class AiCompDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveComparisonText(
    String uid,
    String tag,
    String text,
    ProductCategory ctg,
  ) async {
    try {
      await firestore
          .collection(uid)
          .doc("ai_comparison")
          .collection("products")
          .doc(tag)
          .set({
            "category": ctg.toString(),
            "created_at": DateTime.now(),
            "comp_text": text,
          });
    } catch (e) {
      print("Error saving comparison text: $e");
    }
  }

  Future<Map<String, dynamic>> getComparisonTextWithTag(
    String uid,
    String tag,
  ) async {
    try {
      final docSnapshot = await firestore
          .collection(uid)
          .doc("ai_comparison")
          .collection("products")
          .doc(tag)
          .get();
          
      if (docSnapshot.exists) {
        return docSnapshot.data() as Map<String, dynamic>;
      } else {
        print("Error document is empty");
        return {};
      }
    } catch (e) {
      print("Error fetching summaries with $tag: $e");
      return {};
    }
  }

  Future<List<(String, Map<String, dynamic>)>> getComparisonTexts(
    String uid,
  ) async {
    try {
      final docSnapshot = await firestore
          .collection(uid)
          .doc("ai_comparison")
          .collection("products")
          .get();

      if (docSnapshot.docs.isNotEmpty) {
        final List<(String, Map<String, dynamic>)> document = [];
        final products = docSnapshot.docs.map((doc) => doc.id).toList();
        for (final tag in products) {
          final snapshot = await getComparisonTextWithTag(uid, tag);
          if (snapshot.isNotEmpty) {
            document.add((tag, snapshot));
          }
        }
        return document;
      } else {
        print("Error document is empty");
        return [];
      }
    } catch (e) {
      print("error occurred while fethcing comparison text");
      return [];
    }
  }
}
