import 'package:finbrain/data/model/entities/credit_loan_option.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/product_categories.dart';

// 개인신용대출
class CreditLoan extends FinancialProduct {
  // 프로퍼티명(필드명): 의미
  // commonInfo: 기본 정보
  // productType(crdt_prdt_type): 대출 정보 코드
  // productTypeName(crdt_prdt_type_nm): 대출 정보명
  // cbName(cb_name): CB 회사명
  // options: 옵션 목록

  final String? productType;
  final String? productTypeName;
  final String? cbName;
  final double? maxRate;
  final double? minRate;
  final double? avgRate;
  final List<CreditLoanOption> options;

  CreditLoan({
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
    required this.options,
    required this.maxRate,
    required this.minRate,
    required this.avgRate,
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
    return CreditLoan(
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
      maxRate: maxRate,
      minRate: minRate,
      avgRate: avgRate,
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
      "productTypeName": productType.toString(),
      "cbName": cbName.toString(),
      "maxRate": maxRate.toString(),
      "minRate": minRate.toString(),
      "avgRate": avgRate.toString(),
      "options": options
          .map(
            (e) => {
              "creditLendRateType": e.creditLendRateType,
              "creditLendRateTypeName": e.creditLendRateTypeName,
              "gradeOver900": e.gradeOver900,
              "grade801900": e.grade801900,
              "grade701800": e.grade701800,
              "grade601700": e.grade601700,
              "grade501600": e.grade501600,
              "grade401500": e.grade401500,
              "grade301400": e.grade301400,
              "gradeUnder300": e.gradeUnder300,
              "averageGrade": e.averageGrade,
            },
          )
          .toList(),
    };
  }
}
