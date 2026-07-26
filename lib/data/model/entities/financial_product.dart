import 'package:finbrain/product_categories.dart';

// 금융 상품 공통 정보
// Common information of financial product
class CommonInfo {
  // 프로퍼티명(필드명): 의미
  // submittedMonth(dcls_month): 공시 제출월
  // companyCode(fin_co_no): 금융 회사 코드
  // companyName(kor_co_nm): 금융 회사명
  // productCode(fin_prdt_cd): 금융 상품 코드
  // productName(fin_prdt_nm): 금융 상품명
  // startDay(dcls_start_day): 공시 시작일
  // endDay(dcls_end_day): 공식 종료일
  // submittedDay(fin_co_subm_day): 금융 회사 제출일
  // joinWay(join_way): 가입 방법
  // url: 페이지 주소
  // isLiked: 관심 여부

  final ProductCategory category;
  final String? submittedMonth;
  final String? companyCode;
  final String? companyName;
  final String? productCode;
  final String? productName;
  final String? startDay;
  final String? endDay;
  final String? submittedDay;
  final List<String>? joinWay;
  var isLiked = false;

  CommonInfo({
    required this.category,
    this.submittedMonth,
    this.companyCode,
    required this.companyName,
    this.productCode,
    required this.productName,
    this.startDay,
    this.endDay,
    this.submittedDay,
    this.joinWay,
    required this.isLiked,
  });
}

abstract class FinancialProduct {
  final CommonInfo commonInfo;
  FinancialProduct(this.commonInfo);

  FinancialProduct copyWith(bool isLiked);
  Map<String, Object> toMap();
}
