// ISA MP 대표수익률
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/ui/product_categories.dart';

class IsaMpBenefitRate extends FinancialProduct {
  // 프로퍼티명(필드명): 의미
  // mpName(mpNm): mp명칭
  // releaseDate(rlsDt): 출시일
  // term(trm): 기간
  // benefitRate(bnrRt): 수익률
  // baseDate(basDt): 기준 일자
  // businessDomain(bzds): 업권
  // companyName(cmpyNm): 회사명
  // mpType(mpTp): mp유형

  final String? term;
  final int? benefitRate;
  final String? baseDate;
  final String? businessDomain;
  final String? mpType;

  IsaMpBenefitRate({
    // CommonInfo
    required ProductCategory category,
    required String? url,
    required String? companyName,
    required String? mpName,
    required String? releaseDate,
    required bool isLiked,

    required this.term,
    required this.benefitRate,
    required this.baseDate,
    required this.businessDomain,
    required this.mpType,
  }) : super(
         CommonInfo(
           category: category,
           companyName: companyName,
           productName: mpName,
           submittedDay: releaseDate,
           url: url,
           isLiked: isLiked,
         ),
       );

  @override
  FinancialProduct copyWith(bool isLiked) {
    return IsaMpBenefitRate(
      isLiked: isLiked,
      category: commonInfo.category,
      url: commonInfo.url,
      companyName: commonInfo.companyName,
      mpName: commonInfo.productName,
      releaseDate: commonInfo.submittedDay,
      term: term,
      benefitRate: benefitRate,
      baseDate: baseDate,
      businessDomain: businessDomain,
      mpType: mpType,
    );
  }
}
