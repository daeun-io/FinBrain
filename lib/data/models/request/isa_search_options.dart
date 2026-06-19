class IsaSearchOptions {
  final String serviceKey;
  final String resultType;
  final String pageNo;
  final String numOfRows;

  IsaSearchOptions({
    required this.serviceKey,
    required this.resultType,
    required this.pageNo,
    required this.numOfRows
  });

  Map<String, String> toQueryParams(){
    return {
       "serviceKey": serviceKey,
       "resultType": resultType,
       "pageNo": pageNo,
       "numOfRows": numOfRows
    };
  }
}