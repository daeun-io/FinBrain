import 'dart:convert';
import 'package:finbrain/data/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CmpyRemoteDataSource {
  final http.Client _client;
  CmpyRemoteDataSource(this._client);

  // 업권과 일치하는 회사 주소 가져오기
  // Get companies that matches with given category
  Future<Map<String, dynamic>> fetchCmpyNames(String topFinGrpNo) async {
    final options = {
      "auth": dotenv.env["FINLIFE_API"] ?? "",
      "topFinGrpNo": topFinGrpNo,
      "pageNo": "1",
    };
    final uri = Uri.https(firebase, "/fetchCmpyNameList", options);

    try {
      final res = await _client.get(uri);
      if (res.statusCode == 200) {
        return jsonDecode(res.body) as Map<String, dynamic>;
      } else {
        throw Exception(
          "[error] failed to load companies : ${res.statusCode}, ${res.body}",
        );
      }
    } catch (e) {
      throw Exception("[error] failed to load companies : $e");
    }
  }
}
