import 'dart:convert';
import 'package:charset_converter/charset_converter.dart';
import 'package:finbrain/data/model/request/finlife_search_options.dart';
import 'package:finbrain/data/model/request/isa_search_options.dart';
import 'package:http/http.dart' as http;
import 'package:finbrain/data/api_constants.dart';
import 'package:finbrain/product_categories.dart';
import 'package:xml2json/xml2json.dart';

final stopwatch = Stopwatch()..start();

class ProductRemoteDataSource {
  final http.Client _client;
  ProductRemoteDataSource(this._client);

  // 주어진 업권에 따라 금융한눈에 상품 불러오기
  // Get financial products based on give category
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
        // 받은 xml 텍스트 안 깨지도록 변환
        // Fix character encoding issues to prevent garbled text
        final String xmlBody = await CharsetConverter.decode(
          "EUC-KR",
          res.bodyBytes,
        );
        print('네트워크 대기: ${stopwatch.elapsedMilliseconds}ms');
        print('현재 카테고리: $ctg');
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

  // 필터링 조건 없이 모든 ISA 상품 불러오기
  // Get ISA products without filters
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