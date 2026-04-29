import 'package:finbrain/data/model/entities/common_info.dart';
import 'package:finbrain/data/model/entities/credit_loan_option.dart';

// 개인신용대출
class CreditLoan {
  // 프로퍼티명(필드명): 의미 
  // commonInfo: 기본 정보
  // productType(crdt_prdt_type): 대출 정보 코드
  // productTypeName(crdt_prdt_type_nm): 대출 정보명
  // cbName(cb_name): CB 회사명
  // options: 옵션 목록

  final CommonInfo commonInfo;
  final String? productType;
  final String? productTypeName;
  final String? cbName;
  final List<CreditLoanOption>? options;

  CreditLoan(
    this.commonInfo,
    this.productType,
    this.productTypeName,
    this.cbName,
    this.options
  );
}