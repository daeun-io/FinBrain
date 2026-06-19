import 'dart:convert';
import 'package:finbrain/data/api_constants.dart';
import 'package:http/http.dart' as http;

class IsaRemoteDataSource {
  final http.Client _client;
  IsaRemoteDataSource(this._client);

  Future<Map<String, Object>> fetchJoinStatus(
    String pageNo,
    String numOfRows,
  ) async {
    final queryParams = {
      "serviceKey": "",
      "resultType": "json",
      "pageNo": pageNo,
      "numOfRows": numOfRows,
    };
    final uri = Uri.http(ApiConstants.isa, "/getJoinStatus_V2", queryParams);

    try {
      final res = await _client.get(uri);
      if (res.statusCode == 20) {
        return jsonDecode(res.body);
      } else {
        throw Exception("Failed to load data, ${res.statusCode}");
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<Map<String, Object>> fetchManagementStatus(
    String pageNo,
    String numOfRows,
    String ctg,
  ) async {
    final queryParams = {
      "serviceKey": "",
      "resultType": "json",
      "pageNo": pageNo,
      "numOfRows": numOfRows,
      "ctg": ctg
    };
    final uri = Uri.http(
      ApiConstants.isa,
      "/getManagementStatus_V2",
      queryParams,
    );
    try {
      final res = await _client.get(uri);
      if (res.statusCode == 20) {
        return jsonDecode(res.body);
      } else {
        throw Exception("Failed to load data, ${res.statusCode}");
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
