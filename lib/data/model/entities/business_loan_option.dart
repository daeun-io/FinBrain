// 개인사업자대출 옵션
class BusinessLoanOption {
  // 프로퍼티명(필드명): 의미
  // loanGradeOver900(val1_grad_1): 대출금리 900점 초과
  // loanGrade801900(val1_grad_2): 대출금리 801~900점
  // loanGrade701800(val1_grad_3): 대출금리 701~800점
  // loanGrade601700(val1_grad_4): 대출금리 601~700점
  // loanGrade501600(val1_grad_5): 대출금리 501~600점
  // loanGrade401500(val1_grad_6): 대출금리 401~500점
  // loanGrade301400(val1_grad_7): 대출금리 301~400점
  // loanGradeAvg(val1_grad_avg): 대출금리 평균

  // baseGradeOver900(val2_grad_1): 기준금리 900점 초과
  // baseGrade801900(val2_grad_2): 기준금리 801~900점
  // baseGrade701800(val2_grad_3): 기준금리 701~800점
  // baseGrade601700(val2_grad_4): 기준금리 601~700점
  // baseGrade501600(val2_grad_5): 기준금리 501~600점
  // baseGrade401500(val2_grad_6): 기준금리 401~500점
  // baseGrade301400(val2_grad_7): 기준금리 301~400점
  // baseGradeUnder300(val2_grad_8): 기준금리 300점 이하
  // baseGradeAvg(val2_gra_avg): 기준금리 평균

  // marginGradeOver900(val3_grad_1): 가산금리 900점 초과
  // marginGrade801900(val3_grad_2): 가산금리 801~900점
  // marginGrade701800(val3_grad_3): 가산금리 701~800점
  // marginGrade601700(val3_grad_4): 가산금리 601~700점
  // marginGrade501600(val3_grad_5): 가산금리 501~600점
  // marginGrade401500(val3_grad_6): 가산금리 401~500점
  // marginGrade301400(val3_grad_7): 가산금리 301~400점
  // marginGradeUnder300(val3_grad_8): 가산금리 300점 이하
  // marginGradeAvg(val3_gra_avg): 가산금리 평균

  // minRate(lend_rate_min): 적용이자율(최저)
  // maxRate(lend_rate_max): 적용이자율(최고)
  // avgRate(lend_rate_avg): 전월취급평균이자율

  
  final double? loanGradeOver900;
  final double? loanGrade801900;
  final double? loanGrade701800;
  final double? loanGrade601700;
  final double? loanGrade501600;
  final double? loanGrade401500;
  final double? loanGrade301400;
  final double? loanGradeAvg;

  final double? baseGradeOver900;
  final double? baseGrade801900;
  final double? baseGrade701800;
  final double? baseGrade601700;
  final double? baseGrade501600;
  final double? baseGrade401500;
  final double? baseGrade301400;
  final double? baseGradeAvg;

  final double? marginGradeOver900;
  final double? marginGrade801900;
  final double? marginGrade701800;
  final double? marginGrade601700;
  final double? marginGrade501600;
  final double? marginGrade401500;
  final double? marginGrade301400;
  final double? marginGradeAvg;

  final double? minRate;
  final double? maxRate;
  final double? avgRate;

  const BusinessLoanOption({
    required this.minRate,
    required this.maxRate,
    required this.avgRate,
    
    required this.loanGradeOver900,
    required this.loanGrade801900,
    required this.loanGrade701800,
    required this.loanGrade601700,
    required this.loanGrade501600,
    required this.loanGrade401500,
    required this.loanGrade301400,
    required this.loanGradeAvg,

    required this.baseGradeOver900,
    required this.baseGrade801900,
    required this.baseGrade701800,
    required this.baseGrade601700,
    required this.baseGrade501600,
    required this.baseGrade401500,
    required this.baseGrade301400,
    required this.baseGradeAvg,

    required this.marginGradeOver900,
    required this.marginGrade801900,
    required this.marginGrade701800,
    required this.marginGrade601700,
    required this.marginGrade501600,
    required this.marginGrade401500,
    required this.marginGrade301400,
    required this.marginGradeAvg,
  });
}