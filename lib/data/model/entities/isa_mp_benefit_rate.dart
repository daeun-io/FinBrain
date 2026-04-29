// ISA MP 대표수익률
class IsaMpBenefitRate {
  // 프로퍼티명(필드명): 의미
  // mpName(mpNm): mp명칭
  // releaseDate(rlsDt): 출시일
  // term(trm): 기간
  // benefitRate(bnrRt): 수익률
  // baseDate(basDt): 기준 일자
  // businessDomain(bzds): 업권
  // companyName(cmpyNm): 회사명
  // mpType(mpTp): mp유형

  final String? mpName;
  final String? releaseDate;
  final String? term;
  final int? benefitRate;
  final String? baseDate;
  final String? businessDomain;
  final String? companyName;
  final String? mpType;
  var isLiked = false;

  IsaMpBenefitRate(
    this.mpName,
    this.releaseDate,
    this.term,
    this.benefitRate,
    this.baseDate,
    this.businessDomain,
    this.companyName,
    this.mpType
  );
}