import 'package:finbrain/data/model/entities/common_info.dart';
import 'mortage_and_rent_loan_option.dart';

// 주택담보대출 & 전세자금대출
class MortageAndRentLoan {
  // 프로퍼티명(필드명): 의미 
  // commonInfo: 기본 정보
  // extraExpense(loan_inci_expn): 대출 부대비용
  // earlyReplayFee(erly_rpay_fee): 중도상환 수수료
  // delayRate(dly_rate): 연체 이자율
  // loanLimit(loan_lmt): 대출한도
  // options: 옵션 목록
  
  final CommonInfo commonInfo;
  final String? extraExpense;
  final String? earlyRepayFee;
  final String? delayRate;
  final String? loanLimit;
  final List<MortageAndRentLoanOption>? options;

  MortageAndRentLoan(
    this.commonInfo,
    this.extraExpense,
    this.earlyRepayFee,
    this.delayRate,
    this.loanLimit,
    this.options
  );
}