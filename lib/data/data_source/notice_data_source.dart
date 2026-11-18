import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class NoticeDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
  fetchNotices() async {
    try {
      final docSnapshot = await firestore.collection("notices").get();

      if (docSnapshot.docs.isNotEmpty) {
        return docSnapshot.docs;
      } else {
        debugPrint("[empty] notices are empty");
        return [];
      }
    } catch (e) {
      throw Exception("[error] failed to fetch notices : $e");
    }
  }
}
