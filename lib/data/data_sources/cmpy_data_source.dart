import 'dart:convert';

import 'package:finbrain/data/api_constants.dart';
import 'package:finbrain/data/models/request/finlife_search_options.dart';
import 'package:http/http.dart' as http;

class CmpyRemoteDataSource {
  final http.Client _client;
  CmpyRemoteDataSource(this._client);

  Future<Map<String, Object>> fetchCmpyNames(
    FinlifeSearchOptions options,
  ) async {
    final uri = Uri.https(
      "$ApiConstants.firebase",
      "/fetchCmpyNameList",
      options.toQueryParams(),
    );

    try {
      final res = await _client.get(uri);
      if (res.statusCode == 200) {
        return jsonDecode(res.body) as Map<String, Object>;
      } else {
        throw Exception("Failed to load API, ${res.statusCode}");
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
