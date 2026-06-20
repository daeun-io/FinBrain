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
