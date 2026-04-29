// 개인신용대출 옵션
class CreditLoanOption {
  // 프로퍼티명(필드명): 의미 
  // creditLendRateType(crdt_lend_rate_type): 금리 구분 코드
  // creditLendRateTypeNm(crdt_lend_rate_type_nm): 금리 구분명
  // gradeOver900(crdt_grad_1): 900점 초과
  // grade801900(crdt_grad_4): 801~900
  // grad701800(crdt_grad_5): 701~800
  // grade601700(crdt_grad_6): 601~700
  // grade501600(crdt_grad_10): 501~600
  // grade401500(crdt_grad_11): 401~500
  // grade301400(crdt_grad_12): 301~400
  // gradeUnder300(crdt_grad_13): 300점 이하
  // averageGrade(crdt_grad_avg): 평균 금리
  
  final String? creditLendRateType;
  final String? creditLendRateTypeName;
  final double? gradeOver900;
  final double? grade801900;
  final double? grade701800;
  final double? grade601700;
  final double? grade501600;
  final double? grade401500;
  final double? grade301400;
  final double? gradeUnder300;
  final double? averageGrade;

  const CreditLoanOption(
    this.creditLendRateType,
    this.creditLendRateTypeName,
    this.gradeOver900,
    this.grade801900,
    this.grade701800,
    this.grade601700,
    this.grade501600,
    this.grade401500,
    this.grade301400,
    this.gradeUnder300,
    this.averageGrade
  );
}