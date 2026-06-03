import 'package:collection/collection.dart';
import 'package:finbrain/data/model/entities/credit_loan_option.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/ui/product_categories.dart';

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
    required String? joinWay,
    required String? url,

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
           url: url,
           isLiked: false,
         ),
       );

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
    final min = rates.min;
    final max = rates.max;
    final avg = (avgRates != null) ? avgRates : rates.average;
    return [min, avg, max];
  }
}
