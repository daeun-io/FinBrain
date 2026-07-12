import 'package:finbrain/data/data_source/cmpy_data_source.dart';
import 'package:finbrain/data/converter.dart';
import 'package:finbrain/data/model/request/finlife_search_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:finbrain/product_categories.dart';

class FiltersRepository {
  Future<Map<String, List<(String, bool)>>> fetchFilters(
    ProductCategory ctg,
    String topFinGrpNo,
    int baseYear
  ) async {
    final Map<String, List<(String, bool)>> filters = {};
    if (ctg == ProductCategory.isaJoin ||
        ctg == ProductCategory.isaManagement ||
        ctg == ProductCategory.isaMp) {
      filters["기준년도"] = [(baseYear.toString(), true)];
      filters["업권"] = switch (ctg) {
        ProductCategory.isaJoin => [
          ("총합", true),
          ("보험", true),
          ("은행", true),
          ("증권", true),
        ],
        ProductCategory.isaManagement => [
          ("총합", true),
          ("은행", true),
          ("증권", true),
        ],
        ProductCategory.isaMp => [("은행", true), ("증권", true)],
        _ => [],
      };
      if (ctg == ProductCategory.isaMp) {
        filters["MP 종류"] = [
          ("초저위험", true),
          ("저위험", true),
          ("중위험", true),
          ("고위험", true),
          ("초고위험", true),
        ];
      } else {
        filters["ISA 형태"] = [
          ("신탁형 ISA", true),
          ("일임형 ISA", true),
          ("투자중개형 ISA", true),
        ];
        if (ctg == ProductCategory.isaManagement) {
          filters["구분"] = [("비중", true), ("금액", false)];
        }
      }
    } else {
      final cmpyList = await fetchCmpyNames(topFinGrpNo);

      final selectedFinGroup = getFinGroupName[topFinGrpNo] ?? "";
      final List<String> finGroups = switch (ctg) {
        ProductCategory.deposit || ProductCategory.installment => ["은행", "저축은행"],
        ProductCategory.mortgage || ProductCategory.rent || ProductCategory.credit =>  ["은행", "저축은행", "여신전문", "보험"],
        _ => [],
      };

      filters["금융회사"] = finGroups
          .map((e) => (e, e == selectedFinGroup))
          .toList();
      filters["회사 선택"] = cmpyList
          .map<(String, bool)>((e) => (e, false))
          .toList();
      filters["가입 방법"] = [
        ("영업점", true),
        ("인터넷", true),
        ("스마트폰", true),
        ("모집인", true),
        ("전화(텔레뱅킹)", true),
        ("기타", true),
      ];
    }
    print("filters from repository, $filters");
    return filters;
  }

  Future<Iterable<dynamic>> fetchCmpyNames(String topFinGrpNo) async {
    final client = http.Client();
    final dataStore = CmpyRemoteDataSource(client);
    final options = FinlifeSearchOptions(
      auth: dotenv.env["FINLIFE_API"] ?? "",
      topFinGrpNo: topFinGrpNo,
      pageNo: "1",
    );
    final Map<String, dynamic> result = await dataStore.fetchCmpyNames(options);
    print("cmpy result: $result");
    if (result["result"] == null) {
      print("error: result is null");
      return {};
    }
    if (result["result"]["products"] == null) {
      print("error: product is null");
      return {};
    }

    return result["result"]["products"] as Iterable<dynamic>;
  }
}
