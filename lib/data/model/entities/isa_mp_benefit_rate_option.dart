// ISA MP 대표 수익률 옵션
class IsaMpBenefitRateOption {
  // baseDate(basDt): 기준일자

  final String? baseDate;
  final List<TermAndRate> termAndRate;

  const IsaMpBenefitRateOption({
    required this.baseDate,
    required this.termAndRate
  });
}

class TermAndRate {
  // term(trm): 기간
  // benefitRate(bnrRt): 수익률

  final String? term;
  final String? benefitRate;

  const TermAndRate({
    required this.term,
    required this.benefitRate
  });
}
