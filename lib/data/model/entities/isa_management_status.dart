// ISA 운용현황
class IsaManagementStatus {
  // 프로퍼티명(필드명): 의미
  // baseDate(basDt): 기준 일자
  // businessDomain(bzds): 업권
  // category(ctg): 구분값
  // isaForm(isaForm): ISA 형태
  // includeAssetCtg(incAstCtg): 편입자산구분
  // amount(amt): 금액
  
  final String? baseDate;
  final String? businessDomain;
  final String? category;
  final String? isaForm;
  final String? includeAssetCtg;
  final int? amount;

  const IsaManagementStatus(
    this.baseDate,
    this.businessDomain,
    this.category,
    this.isaForm,
    this.includeAssetCtg,
    this.amount
  );
}