import 'dart:convert';
import 'package:charset_converter/charset_converter.dart';
import 'package:finbrain/data/model/request/finlife_search_options.dart';
import 'package:finbrain/data/model/request/isa_search_options.dart';
import 'package:http/http.dart' as http;
import 'package:finbrain/data/api_constants.dart';
import 'package:finbrain/product_categories.dart';
import 'package:xml2json/xml2json.dart';

class ProductRemoteDataSource {
  final http.Client _client;
  ProductRemoteDataSource(this._client);

  Future<Map<String, dynamic>> fetchFinlifeProducts(
    ProductCategory ctg,
    FinlifeSearchOptions options,
  ) async {
    final uri = switch (ctg) {
      ProductCategory.deposit => Uri.http(
        finlife,
        '/finlifeapi/depositProductsSearch.xml',
        options.toQueryParams(),
      ),
      ProductCategory.installment => Uri.http(
        finlife,
        '/finlifeapi/savingProductsSearch.xml',
        options.toQueryParams(),
      ),
      ProductCategory.mortgage => Uri.http(
        finlife,
        '/finlifeapi/mortgageLoanProductsSearch.xml',
        options.toQueryParams(),
      ),
      ProductCategory.rent => Uri.http(
        finlife,
        '/finlifeapi/rentHouseLoanProductsSearch.xml',
        options.toQueryParams(),
      ),
      _ => Uri.http(
        finlife,
        '/finlifeapi/creditLoanProductsSearch.xml',
        options.toQueryParams(),
      ),
    };
    try {
      final res = await _client.get(uri);
      if (res.statusCode == 200) {
        final String xmlBody = await CharsetConverter.decode(
          "EUC-KR",
          res.bodyBytes,
        );
        final formatter = Xml2Json();
        formatter.parse(xmlBody);
        final jsonStr = formatter.toParker();
        final Map<String, dynamic> jsonMap = jsonDecode(jsonStr);
        return jsonMap;
      } else {
        throw Exception(
          "[error] failed to load finlife products : ${res.statusCode}, ${res.body}",
        );
      }
    } catch (e) {
      throw Exception("[error] failed to load finlife products : $e");
    }
  }

  Future<Map<String, dynamic>> fetchIsaMpProducts(
    IsaSearchOptions options,
  ) async {
    final queryParams = {
      ...options.toQueryParams(),
      "bzds": "",
      "mpTp": "",
      "likeCmpyNm": "",
    };
    final uri = Uri.https(firebase, "/fetchAndGroupProducts", queryParams);

    try {
      final res = await _client.get(uri);
      if (res.statusCode == 200) {
        return jsonDecode(res.body) as Map<String, dynamic>;
      } else {
        throw Exception(
          "[error] failed to load isa mp products : ${res.statusCode}, ${res.body}",
        );
      }
    } catch (e) {
      throw Exception("[error] failed to load isa mp products : $e");
    }
  }
}
