// ISA 업권별 가입 현황
class IsaJoinStatus {
  // 프로퍼티명(필드명): 의미
  // companyCount(cmpyCnt): 회사수
  // joinMemberCount(joinMemberCnt): 가입자수
  // baseDate(basDt): 기준 일자
  // isaForm(isaForm): ISA 형태
  // category(ctg): 업권값

  final int? companyCount;
  final int? joinMemberCount;
  final int? investmentAmount;
  final String? baseDate;
  final String? isaForm;
  final String? category;

  const IsaJoinStatus(
    this.companyCount,
    this.joinMemberCount,
    this.investmentAmount,
    this.baseDate,
    this.isaForm,
    this.category
  );
}