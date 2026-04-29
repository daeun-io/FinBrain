// 금융회사
class FinanceCompany {
  // 프로퍼티명(필드명): 의미
  // submittedMonth(dcls_month): 공시 제출월
  // companyCode(fin_co_no): 금융 회사 코드
  // companyName(kor_co_nm): 금융 회사명
  // chargeMan(dcls_chrg_man): 공시 담당자
  // homeUrl(home_url) : 홈페이지 주소
  // telephone(cal_tel): 콜센터 전화번호

  final String? submittedMonth;
  final String? companyCode;
  final String? companyName;
  final String? chargeMan;
  final String? homeUrl;
  final String? telephone;

  const FinanceCompany(
    this.submittedMonth, 
    this.companyCode, 
    this.companyName, 
    this.chargeMan,
    this.homeUrl,
    this.telephone
  );
}