import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings_option.dart';
import 'package:finbrain/product_categories.dart';

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
  final double? maxPrfRate;
  final double? maxBaseRate;
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
    required bool isLiked,

    required this.interestAfterExpiration,
    required this.specialCondition,
    required this.joinDeny,
    required this.joinMember,
    required this.etc,
    required this.maxLimit,
    required this.maxPrfRate,
    required this.maxBaseRate,
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
    return DepositAndInstallmentSavings(
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
      interestAfterExpiration: interestAfterExpiration,
      specialCondition: specialCondition,
      joinDeny: joinDeny,
      joinMember: joinMember,
      etc: etc,
      maxLimit: maxLimit,
      maxPrfRate: maxPrfRate,
      maxBaseRate: maxBaseRate,
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
      "interestAfterExpiration": interestAfterExpiration.toString(),
      "specialCondition": specialCondition.toString(),
      "joinDeny": joinDeny.toString(),
      "joinMember": joinMember.toString(),
      "etc": etc.toString(),
      "maxLimit": maxLimit.toString(),
      "maxPrfRate": maxPrfRate ?? "null",
      "maxBaseRate": maxBaseRate ?? "null",
      "options": options
          .map(
            (e) => {
              "intRateType": e.intRateType,
              "intRateTypeName": e.intRateTypeName,
              "saveTerm": e.saveTerm,
              "intRate": e.intRate,
              "maxIntRate": e.maxIntRate,
              "reserveType": e.reserveType,
              "reserveTypeName": e.reserveTypeName,
            },
          )
          .toList(),
    };
  }
}
