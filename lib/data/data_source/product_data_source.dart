import 'dart:convert';
import 'package:finbrain/data/model/request/finlife_search_options.dart';
import 'package:finbrain/data/model/request/isa_search_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:finbrain/data/api_constants.dart';
import 'package:finbrain/product_categories.dart';

class ProductRemoteDataSource {
  final http.Client _client;
  ProductRemoteDataSource(this._client);

  // 주어진 업권에 따라 금융한눈에 상품 불러오기
  // Get financial products based on give category
  Future<Map<String, dynamic>> fetchFinlifeProducts(
    ProductCategory ctg,
    String topFinGrpNo, [
    List<String>? selectedCompany,
    List<String>? selectedJoinWay,
  ]) async {
    final key = dotenv.env["FINLIFE_API"] ?? "";

    final category = switch (ctg) {
      ProductCategory.deposit => "deposit",
      ProductCategory.installment => "installment",
      ProductCategory.mortgage => "mortgage",
      ProductCategory.rent => "rent",
      ProductCategory.credit => "credit",
      ProductCategory.business => "business",
      _ => "",
    };

    final params = FinlifeSearchOptions(
      auth: key,
      category: category,
      topFinGrpNo: topFinGrpNo,
      selectedCompany: selectedCompany,
      selectedJoinWay: selectedJoinWay
    );

    final uri = Uri.https(
      firebase,
      "/fetchFinlifeProducts",
      params.toQueryParams(),
    );
    try {
      final res = await _client.get(uri);
      if (res.statusCode == 200) {
        return jsonDecode(res.body) as Map<String, dynamic>;
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
