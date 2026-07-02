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