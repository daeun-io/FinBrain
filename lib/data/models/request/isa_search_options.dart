class IsaSearchOptions {
  final String serviceKey;
  final String resultType;
  final String pageNo;
  final String numOfRows;
  final String baseYearMonth;

  IsaSearchOptions({
    required this.serviceKey,
    required this.resultType,
    required this.pageNo,
    required this.numOfRows,
    required this.baseYearMonth,
  });

  Map<String, String> toQueryParams(){
    return {
       "serviceKey": serviceKey,
       "resultType": resultType,
       "pageNo": pageNo,
       "numOfRows": numOfRows,
       "likeBasDt": baseYearMonth,
    };
  }
}