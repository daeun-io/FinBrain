import 'dart:convert';
import 'package:finbrain/data/api_constants.dart';
import 'package:finbrain/data/models/request/isa_search_options.dart';
import 'package:http/http.dart' as http;

class IsaRemoteDataSource {
  final http.Client _client;
  IsaRemoteDataSource(this._client);

  Future<Map<String, dynamic>> fetchJoinStatus(
    IsaSearchOptions options,
    String domain,
    String isaForm,
  ) async {
    final queryParams = {
      ...options.toQueryParams(),
      "ctg": domain,
      "likeIsaForm": isaForm,
    };
    final uri = Uri.https(public, '$isa/getJoinStatus_V2', queryParams);

    try {
      final res = await _client.get(uri);
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        throw Exception("error: Failed to get a response, ${res.statusCode}");
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<Map<String, dynamic>> fetchManagementStatus(
    IsaSearchOptions options,
    String ctg,
    String domain,
    String isaForm,
  ) async {
    final queryParams = {
      ...options.toQueryParams(),
      "ctg": ctg,
      "bzds": domain,
      "likeIsaForm": isaForm,
    };
    final uri = Uri.http(
      public,
      '$isa/getManagementStatus_V2',
      queryParams,
    );
    try {
      final res = await _client.get(uri);
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        throw Exception("error: Failed to get a response, ${res.statusCode}");
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
