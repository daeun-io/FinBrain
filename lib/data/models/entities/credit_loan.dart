import 'package:collection/collection.dart';
import 'package:finbrain/data/models/entities/credit_loan_option.dart';
import 'package:finbrain/data/models/entities/financial_product.dart';
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
      options: options,
    );
  }

  List<double> returnRates() {
    final foundOption = options
        .where((e) => e.creditLendRateTypeName == "대출금리")
        .firstOrNull;

    if (foundOption == null) return [];
    final rates = [
      foundOption.gradeOver900,
      foundOption.grade801900,
      foundOption.grade701800,
      foundOption.grade601700,
      foundOption.grade501600,
      foundOption.grade401500,
      foundOption.grade301400,
      foundOption.gradeUnder300,
    ].whereType<double>();

    final avgRates = foundOption.averageGrade;
    final min = rates.minOrNull ?? double.infinity;
    final max = rates.minOrNull ?? double.infinity;
    final avg = (avgRates != null) ? avgRates : rates.average;
    return [min, avg, max];
  }
}
