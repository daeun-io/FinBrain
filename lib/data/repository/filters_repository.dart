import 'package:finbrain/data/data_sources/cmpy_data_source.dart';
import 'package:finbrain/data/fin_group_code.dart';
import 'package:finbrain/data/models/request/finlife_search_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:finbrain/product_categories.dart';

class FiltersRepository {
  Future<Map<String, Object>> fetchFilters(
    FilterTextCategory ctg,
    String topFinGrpNo,
    String pageNo,
  ) async {
    final Map<String, Object> filters = {};
    if (ctg == FilterTextCategory.isaJoin ||
        ctg == FilterTextCategory.isaManagement ||
        ctg == FilterTextCategory.isaMp) {
      final now = DateTime.now();
      filters["기준 연월"] = "${now.year}${now.month}";
      filters["업권"] = switch (ctg) {
        FilterTextCategory.isaJoin => [
          ("총합", true),
          ("보험", true),
          ("은행", true),
          ("증권", true),
        ],
        FilterTextCategory.isaManagement => [
          ("총합", true),
          ("은행", true),
          ("증권", true),
        ],
        FilterTextCategory.isaMp => [("은행", true), ("증권", true)],
        _ => [],
      };
      if (ctg == FilterTextCategory.isaMp) {
        filters["MP 종류"] = [("저위험", true), ("중위험", true), ("고위험", true)];
      } else {
        filters["ISA 형태"] = [("신탁형", true), ("일임형", true), ("투자중개형", true)];
      }
    } else {
      final client = http.Client();
      final dataStore = CmpyRemoteDataSource(client);
      final options = FinlifeSearchOptions(
        auth: dotenv.env["FINLIFE_API"] ?? "",
        topFinGrpNo: topFinGrpNo,
        pageNo: pageNo,
      );
      final Map<String, dynamic> result = await dataStore.fetchCmpyNames(
        options,
      );
      final List<String> cmpyList = result["result"]["products"];
      final selectedFinGroup = getFinGroupName[topFinGrpNo] ?? "";
      final List<String> finGroups = switch (ctg) {
        FilterTextCategory.savings => ["은행", "저축은행"],
        FilterTextCategory.loan => ["은행", "저축은행", "여신전문", "보험"],
        FilterTextCategory.annuity => ["보험", "금융투자"],
        _ => [],
      };
      filters["금융회사"] = finGroups
          .map((e) => (e, e == selectedFinGroup))
          .toList();
      filters["회사 선택"] = cmpyList.map((e) => (e, false)).toList();
      filters["가입 방법"] = [
        ("영업점", true),
        ("인터넷", true),
        ("스마트폰", true),
        ("모집인", true),
        ("전화(텔레뱅킹)", true),
        ("기타", true),
      ];
    }
    return filters;
  }

  Future<Map<String, Object>> saveChanges(
    Map<String, Object> newFilters,
  ) async => newFilters;
}
