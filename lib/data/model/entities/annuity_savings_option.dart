// 연금저축 옵션
class AnnuitySavingsOption {
  // 프로퍼티명(필드명): 의미 
  // receiptTerm(pnsn_recp_trm): 연금 수령 기간
  // receiptTermName(pnsn_recp_trn_nm): 연금 수령 기간 명칭
  // entryAge(pnsn_entr_age): 가입 시점 연령
  // entryAgeName(pnsn_entr_age_nm): 가입 시점 연령 명칭
  // monthlyPayment(mon_paym_atm): 월 납입액
  // monthlyPaymentName(mon_paym_atm_nm): 월 납입액 명칭
  // paymentPeriod(paym_prd): 납입 기간
  // paymentPeriodName(paym_prd_nm): 납입 기간 명칭
  // startAge(pnsn_strt_age): 개시 연령
  // startAgeName(pnsn_strt_age_nm): 개시 연령 명칭
  // monthlyReceiptAmount(pnsn_recp_amt): 월 예상 수령액
  
  final String? receiptTerm;
  final String? receiptTermName;
  final String? entryAge;
  final String? entryAgeName;
  final String? monthlyPayment;
  final String? monthlyPaymentName;
  final String? paymentPeriod;
  final String? paymentPeriodName;
  final String? startAge;
  final String? startAgeName;
  final String? monthlyReceiptAmount;

  AnnuitySavingsOption(
    this.receiptTerm,
    this.receiptTermName,
    this.entryAge,
    this.entryAgeName,
    this.monthlyPayment,
    this.monthlyPaymentName,
    this.paymentPeriod,
    this.paymentPeriodName,
    this.startAge,
    this.startAgeName,
    this.monthlyReceiptAmount
  );
}