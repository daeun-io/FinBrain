import 'package:finbrain/data/model/entities/common_info.dart';
import 'annuity_savings_option.dart';

// 연금저축
class AnnuitySavings {
  // 프로퍼티명(필드명): 의미
  // commonInfo: 기본 정보
  // pensionKind(pnsn_kind): 연금 종류
  // pensionKindName(pnsn_kind_nm): 연금 종류명
  // saleStartDay(sale_strt_day): 판매 개시일
  // maintenanceCount(mtnt_cnt): 유지건수/설정액
  // productType(prdt_type): 상품 유형
  // productTypeName(prdt_type_nm): 상품 유형명 
  // averageCommision(avg_prft_rate): 평균 수수료
  // declaredRate(dcls_rate): 공시 이율
  // guaranteedRate(guar_rate): 최저 보증 이율
  // pyProfitRate(brtm_prft_rate1): 전년도 수익률
  // ppyProfitRate(brtm_prft_rate2): 전전년도 수익률
  // ppyProfitRate(brtm_prft_rate3): 전전전년도수 익률
  // etc(etc): 기타사항
  // saleCompany(sale_co): 판매사
  // options: 옵션 목록
  
  final CommonInfo commonInfo;
  final String? pensionKind;
  final String? pensionKindName;
  final String? saleStartDay;
  final String? maintenanceCount;
  final String? productType;
  final String? productTypeName;
  final double? averageCommision;
  final String? declaredRate;
  final String? guaranteedRate;
  final String? pyProfitRate;
  final String? ppyProfitRate;
  final String? pppyProfitRate;
  final String? etc;
  final String? saleCompany; 
  final List<AnnuitySavingsOption> options;

  const AnnuitySavings(
    this.commonInfo,
    this.pensionKind,
    this.pensionKindName,
    this.saleStartDay,
    this.maintenanceCount,
    this.productType,
    this.productTypeName,
    this.averageCommision,
    this.declaredRate,
    this.guaranteedRate,
    this.pyProfitRate,
    this.ppyProfitRate,
    this.pppyProfitRate,
    this.etc,
    this.saleCompany,
    this.options
  );
}