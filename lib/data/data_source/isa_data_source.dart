import 'dart:convert';
import 'package:finbrain/data/api_constants.dart';
import 'package:finbrain/data/model/request/isa_search_options.dart';
import 'package:http/http.dart' as http;

class IsaRemoteDataSource {
  final http.Client _client;
  IsaRemoteDataSource(this._client);

  // 주어진 조건에 따라 ISA 가입 현황 불러오기
  // Get Isa join status with given condition
  Future<Map<String, dynamic>> fetchJoinStatus(IsaSearchOptions options) async {
    final queryParams = {...options.toQueryParams()};
    final uri = Uri.https(public, '$isa/getJoinStatus_V2', queryParams);

    try {
      final res = await _client.get(uri);
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        throw Exception(
          "[error] failed to load isa join status : ${res.statusCode}, ${res.body}",
        );
      }
    } catch (e) {
      throw Exception("[error] failed to load isa join status : $e");
    }
  }

  // 주어진 조건에 따라 ISA 운용 현황 불러오기
  // Get Isa management status with given condition
  Future<Map<String, dynamic>> fetchManagementStatus(
    IsaSearchOptions options,
    String ctg,
  ) async {
    final queryParams = {...options.toQueryParams(), "ctg": ctg};
    final uri = Uri.http(public, '$isa/getManagementStatus_V2', queryParams);
    try {
      final res = await _client.get(uri);
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        throw Exception(
          "[error] failed to load isa management status : ${res.statusCode}, ${res.body}",
        );
      }
    } catch (e) {
      throw Exception("[error] failed to load isa management status : $e");
    }
  }
}
