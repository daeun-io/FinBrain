// 정기예금, 적금 옵션
class DepositAndInstallmentSavingsOption {
  // 프로퍼티명(필드명): 의미
  // intRateType(int_rate_type): 저축 금리 유형
  // intRateTypeName(int_rate_type_nm): 저축 금리 유형명
  // saveTerm(save_trm): 저축 기간
  // intRate(int_rate): 저축 금리
  // maxIntRate(int_rate2): 최고 우대 금리
  // reserveType(rsrv_type): 적립 유형
  // reserveTypeName(rsrv_type_nm): 적립 유형명
  
  final String? intRateType;
  final String? intRateTypeName;
  final int? saveTerm;
  final double? intRate;
  final double? maxIntRate;
  final String? reserveType;
  final String? reserveTypeName;

  const DepositAndInstallmentSavingsOption(
    this.intRateType,
    this.intRateTypeName,
    this.saveTerm,
    this.intRate,
    this.maxIntRate,
    this.reserveType,
    this.reserveTypeName
  );
}