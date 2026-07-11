import 'package:collection/collection.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/product_categories.dart';
import 'mortage_and_rent_loan_option.dart';

// 주택담보대출 & 전세자금대출
class MortageAndRentLoan extends FinancialProduct {
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
  final List<MortageAndRentLoanOption> options;

  MortageAndRentLoan({
    // commonInfo
    required ProductCategory category,
    required String? submittedMonth,
    required String? companyCode,
    required String? companyName,
    required String? productCode,
    required String? productName,
    required String? startDay,
    required String? endDay,
    required String? submittedDay,
    required List<String>? joinWay,
    required bool isLiked,

    required this.extraExpense,
    required this.earlyRepayFee,
    required this.delayRate,
    required this.loanLimit,
    required this.options,
  }) : super(
         CommonInfo(
           category: category,
           submittedMonth: submittedMonth,
           companyCode: companyCode,
           companyName: companyName,
           productCode: productCode,
           productName: productName,
           startDay: startDay,
           endDay: endDay,
           submittedDay: submittedDay,
           joinWay: joinWay,
           isLiked: isLiked,
         ),
       );

  @override
  FinancialProduct copyWith(bool isLiked) {
    return MortageAndRentLoan(
      isLiked: isLiked,
      category: commonInfo.category,
      submittedMonth: commonInfo.submittedMonth,
      companyCode: commonInfo.companyCode,
      companyName: commonInfo.companyName,
      productCode: commonInfo.productCode,
      productName: commonInfo.productName,
      startDay: commonInfo.startDay,
      endDay: commonInfo.endDay,
      submittedDay: commonInfo.submittedDay,
      joinWay: commonInfo.joinWay,
      extraExpense: extraExpense,
      earlyRepayFee: earlyRepayFee,
      delayRate: delayRate,
      loanLimit: loanLimit,
      options: options,
    );
  }

  @override
  Map<String, Object> toMap() {
    return {
      "isLiked": true,
      "category": "${commonInfo.category}",
      "submittedMonth": "${commonInfo.submittedMonth}",
      "companyCode": "${commonInfo.companyCode}",
      "companyName": "${commonInfo.companyName}",
      "productCode": "${commonInfo.productCode}",
      "productName": "${commonInfo.productName}",
      "startDay": "${commonInfo.startDay}",
      "endDay": "${commonInfo.endDay}",
      "submittedDay": "${commonInfo.submittedDay}",
      "joinWay": commonInfo.joinWay ?? [],
      "extraExpense": "$extraExpense",
      "earlyRepayFee": "$earlyRepayFee",
      "delayRate": "$delayRate",
      "loanLimit": "$loanLimit",
      "options": options
          .map(
            (e) => {
              "loanType": e.loanType,
              "loanTypeName": e.loanTypeName,
              "repayType": e.repayType,
              "repayTypeName": e.repayTypeName,
              "lendRateType": e.lendRateType,
              "lendRateTypeName": e.lendRateTypeName,
              "lendRateMin": e.lendRateMin,
              "lendRateMax": e.lendRateMax,
              "lendRateAvg": e.lendRateAvg,
            },
          )
          .toList(),
    };
  }

  List<double?> returnRates() {
    final min =
        options.map((e) => (e).lendRateMin).whereType<double>().minOrNull;
    final max =
        options.map((e) => (e).lendRateMax).whereType<double>().minOrNull;
    final avg =
        options.map((e) => (e).lendRateAvg).whereType<double>().minOrNull;
    return [min, avg, max];
  }
}
