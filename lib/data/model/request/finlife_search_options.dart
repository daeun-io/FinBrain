// 금융한눈에 API 쿼리 패러미터
// Query parameters for finlife api
class FinlifeSearchOptions {
  final String auth;
  final String topFinGrpNo;
  final String pageNo;

  FinlifeSearchOptions({
    required this.auth,
    required this.topFinGrpNo,
    required this.pageNo,
  });

  Map<String, String> toQueryParams(){
    return {
       "auth": auth,
       "topFinGrpNo": topFinGrpNo,
       "pageNo": pageNo,
    };
  }
}