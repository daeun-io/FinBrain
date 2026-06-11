import 'package:collection/collection.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings_option.dart';
import 'package:finbrain/ui/product_categories.dart';

// 정기예금, 적금
class DepositAndInstallmentSavings extends FinancialProduct {
  // 프로퍼티명(필드명): 의미
  // commonInfo: 공통 정보
  // interestAfterExpiration(mrnt_int): 만기 후 이자율
  // specialCondition(spcl_cnd): 우대조건
  // joinDeny(join_deny): 가입 제한 - 추후 수정
  // joinMember(join_member): 가입 대상
  // etc(etc_note): 기타 주의사항
  // options: 옵션 목록

  final String? interestAfterExpiration;
  final String? specialCondition;
  final String? joinDeny;
  final String? joinMember;
  final String? etc;
  final String? maxLimit;
  final List<DepositAndInstallmentSavingsOption> options;

  DepositAndInstallmentSavings({
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
    required String? url,
    required bool isLiked,

    required this.interestAfterExpiration,
    required this.specialCondition,
    required this.joinDeny,
    required this.joinMember,
    required this.etc,
    required this.maxLimit,
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
           url: url,
           isLiked: isLiked,
         ),
       );

  @override
  FinancialProduct copyWith(bool isLiked) {
    return DepositAndInstallmentSavings(
      isLiked : isLiked,
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
      url: commonInfo.url,
      interestAfterExpiration: interestAfterExpiration,
      specialCondition: specialCondition,
      joinDeny: joinDeny,
      joinMember: joinMember,
      etc: etc,
      maxLimit: maxLimit,
      options: options,
    );
  }

  (double, double) returnHighestRateValue() {
    final maxRate = options.map((e) => e.maxIntRate).whereType<double>().max;
    final baseRate = options.map((e) => e.intRate).whereType<double>().max;
    return (maxRate, baseRate);
  }
}
