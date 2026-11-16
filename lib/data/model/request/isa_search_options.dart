// ISA 다모아 API 쿼리 패러미터
// Query parameters for searching isa api
class IsaSearchOptions {
  final String serviceKey;
  final String baseYear;
  final List<String>? bzds;
  final List<String>? mpTp;

  IsaSearchOptions({
    required this.serviceKey,
    required this.baseYear,
    this.bzds,
    this.mpTp
  });

  Map<String, dynamic> toQueryParams(){
    return {
       "serviceKey": serviceKey,
       "likeBasDt": baseYear,
       "bzds": bzds,
       "mpTp": mpTp,
    };
  }
}