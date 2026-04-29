// 주택담보대출 & 전세자금대출 옵션
class MortageAndRentLoanOption {
  // 프로퍼티명(필드명): 의미 
  // loanType(mrtg_type): 담보유형 코드
  // loanTypeName(mrtg_type_nm): 담보유형
  // repayType(rpay_type): 대출상환유형 코드
  // repayTypeName(rpay_type_nm): 대출상환유형
  // lendRAteType(lend_rate_type): 대출금리유형 코드
  // lendRateTypeName(lend_rate_type_nm): 대출금리유형 코드
  // lendRateMin(lend_rate_min): 최저 대출 금리
  // lendRateMax(lend_rate_max): 최대 대출 금리
  // lendRateAvg(lend_rate_avg): 평균 대출 금리

  final String? loanType;
  final String? loanTypeName;
  final String? repayType;
  final String? repayTypeName;
  final String? lendRateType;
  final String? lendRateTypeName;
  final double? lendRateMin;
  final double? lendRateMax;
  final double? lendRateAvg;

  const MortageAndRentLoanOption(
    this.loanType,
    this.loanTypeName,
    this.repayType,
    this.repayTypeName,
    this.lendRateType,
    this.lendRateTypeName,
    this.lendRateMin,
    this.lendRateMax,
    this.lendRateAvg
  );
}