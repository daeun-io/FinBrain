// 금융한눈에 API 쿼리 패러미터
// Query parameters for finlife api
class FinlifeSearchOptions {
  final String auth;
  final String category;
  final String topFinGrpNo;
  List<String>? selectedCompany;
  List<String>? selectedJoinWay;

  FinlifeSearchOptions({
    required this.auth,
    required this.category,
    required this.topFinGrpNo,
    this.selectedCompany,
    this.selectedJoinWay
  });

  Map<String, dynamic> toQueryParams() {
    return {
      "auth": auth,
      "category": category,
      "topFinGrpNo": topFinGrpNo,
      "selectedCompany": selectedCompany,
      "selectedJoinWay": selectedJoinWay,
    };
  }
}
