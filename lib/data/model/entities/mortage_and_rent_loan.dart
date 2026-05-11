import 'package:finbrain/data/model/entities/financial_product.dart';
import 'mortage_and_rent_loan_option.dart';

// 주택담보대출 & 전세자금대출
class MortageAndRentLoan extends FinancialProduct{
  // 프로퍼티명(필드명): 의미 
  // commonInfo: 기본 정보
  // extraExpense(loan_inci_expn): 대출 부대비용
  // earlyReplayFee(erly_rpay_fee): 중도상환 수수료
  // delayRate(dly_rate): 연체 이자율
  // loanLimit(loan_lmt): 대출한도
  // options: 옵션 목록
  
  final String? extraExpense;
  final String? earlyRepayFee;
  final String? delayRate;
  final String? loanLimit;
  final List<MortageAndRentLoanOption>? options;

  MortageAndRentLoan({
    // commonInfo
    required String? submittedMonth,
    required String? companyCode,
    required String? companyName,
    required String? productCode,
    required String? productName,
    required String? startDay,
    required String? endDay,
    required String? submittedDay,
    required String? joinWay,
    required String? url,
    
    required this.extraExpense,
    required this.earlyRepayFee,
    required this.delayRate,
    required this.loanLimit,
    required this.options
  }) : super(CommonInfo(
        submittedMonth: submittedMonth,
        companyCode: companyCode,
        companyName: companyName, 
        productCode: productCode, 
        productName: productName, 
        startDay: startDay, 
        endDay: endDay, 
        submittedDay: submittedDay,
        joinWay: joinWay, 
        url: url
      ));
}