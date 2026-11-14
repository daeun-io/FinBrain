import 'package:finbrain/data/model/entities/business_loan_option.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/product_categories.dart';

// 개인신용대출
class BusinessLoan extends FinancialProduct {
  // 프로퍼티명(필드명): 의미
  // commonInfo: 기본 정보
  // productType(crdt_prdt_type): 대출 정보 코드
  // productTypeName(crdt_prdt_type_nm): 대출 정보명
  // cbName(cb_name): CB 회사명
  // loanType(loan_type): 대출 종류
  // repayType(rpay_type): 상환방식
  // rateType(lend_rate_type): 금리방식
  // loanLimit(loan_limit): 대출한도
  // loanLimitDetail(loan_limit_detl): 대출한도(세부요건)
  // joinDeny(join_deny): 가입조건
  // joinDenyDetail(join_deny_detl): 가입조건(세부요건)
  // specialRate(spcl_rate): 우대금리
  // loanTerm(loan_term): 대출기간
  // extraExpense(loan_inci_expn): 대출 부대비용
  // earlyReplayFee(erly_rpay_fee): 중도상환 수수료
  // delayRate(dly_rate): 연체 이자율
  // useWay(use_way): 자금용도

  final String? productType;
  final String? productTypeName;
  final String? cbName;
  final String? loanType;
  final String? repayType;
  final String? rateType;
  final String? loanLimit;
  final String? loanLimitDetail;
  final String? joinDeny;
  final String? joinDenyDetail;
  final String? specialRate;
  final String? loanTerm;
  final String? extraExpense;
  final String? earlyRepayFee;
  final String? delayRate;
  final String? useWay;
  final List<BusinessLoanOption> options;

  BusinessLoan({
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

    required this.productType,
    required this.productTypeName,
    required this.cbName,
    required this.loanType,
    required this.repayType,
    required this.rateType,
    required this.loanLimit,
    required this.loanLimitDetail,
    required this.joinDeny,
    required this.joinDenyDetail,
    required this.specialRate,
    required this.loanTerm,
    required this.extraExpense,
    required this.earlyRepayFee,
    required this.delayRate,
    required this.useWay,
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
    return BusinessLoan(
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
      productType: productType,
      productTypeName: productTypeName,
      cbName: cbName,
      loanType: loanType,
      repayType: repayType,
      rateType: rateType,
      loanLimit: loanLimit,
      loanLimitDetail: loanLimitDetail,
      joinDeny: joinDeny,
      joinDenyDetail: joinDenyDetail,
      specialRate: specialRate,
      loanTerm: loanTerm,
      extraExpense: extraExpense,
      earlyRepayFee: earlyRepayFee,
      delayRate: delayRate,
      useWay: useWay,
      options: options,
    );
  }

  
  @override
  Map<String, Object> toMap() {
    return {
      "isLiked": true,
      "category": commonInfo.category.toString(),
      "submittedMonth": commonInfo.submittedMonth.toString(),
      "companyCode": commonInfo.companyCode.toString(),
      "companyName": commonInfo.companyName.toString(),
      "productCode": commonInfo.productCode.toString(),
      "productName": commonInfo.productName.toString(),
      "startDay": commonInfo.startDay.toString(),
      "endDay": commonInfo.endDay.toString(),
      "submittedDay": commonInfo.submittedDay.toString(),
      "joinWay": commonInfo.joinWay ?? [],
      "productType": productType.toString(),
      "productTypeName": productTypeName.toString(),
      "cbName": cbName.toString(),
      "loanType": loanType.toString(),
      "repayType": repayType.toString(),
      "loanLimit": loanLimit.toString(),
      "loanLimitDetail": loanLimitDetail.toString(),
      "joinDeny": joinDeny.toString(),
      "joinDenyDetail": joinDenyDetail.toString(),
      "specialRate": specialRate.toString(),
      "loanTerm": loanTerm.toString(),
      "extraExpense": extraExpense.toString(),
      "earlyRepayFee": earlyRepayFee.toString(),
      "delayRate": delayRate.toString(),
      "useWay": useWay.toString(),
      "options": options.map((e) => {
        "minRate": e.minRate,
        "maxRate": e.maxRate,
        "avgRate": e.avgRate,
        "loanGradeOver900": e.loanGradeOver900,
        "loanGrade801900": e.loanGrade801900,
        "loanGrade701800": e.loanGrade701800,
        "loanGrade601700": e.loanGrade601700,
        "loanGrade501600": e.loanGrade501600,
        "loanGrade401500": e.loanGrade401500,
        "loanGrade301400": e.loanGrade301400,
        "loanGradeUnder300": e.loanGradeUnder300,
        "loanGradeAvg": e.loanGradeAvg,
        "baseGradeOver900": e.baseGradeOver900,
        "baseGrade801900": e.baseGrade801900,
        "baseGrade701800": e.baseGrade701800,
        "baseGrade601700": e.baseGrade601700,
        "baseGrade501600": e.baseGrade501600,
        "baseGrade401500": e.baseGrade401500,
        "baseGrade301400": e.baseGrade301400,
        "baseGradeUnder300": e.baseGradeUnder300,
        "baseGradeAvg": e.baseGradeAvg,
        "marginGradeOver900": e.marginGradeOver900,
        "marginGrade801900": e.marginGrade801900,
        "marginGrade701800": e.marginGrade701800,
        "marginGrade601700": e.marginGrade601700,
        "marginGrade501600": e.marginGrade501600,
        "marginGrade401500": e.marginGrade401500,
        "marginGrade301400": e.marginGrade301400,
        "marginGradeUnder300": e.marginGradeUnder300,
        "marginGradeAvg": e.marginGradeAvg,
      }).toList()
    };
  }
}
