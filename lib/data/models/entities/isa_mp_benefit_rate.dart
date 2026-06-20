// ISA MP 대표수익률
import 'package:finbrain/data/models/entities/financial_product.dart';
import 'package:finbrain/data/models/entities/isa_mp_benefit_rate_option.dart';
import 'package:finbrain/product_categories.dart';

class IsaMpBenefitRate extends FinancialProduct {
  // 프로퍼티명(필드명): 의미
  // mpName(mpNm): mp명칭
  // releaseDate(rlsDt): 출시일
  // baseDate(basDt): 기준 일자
  // businessDomain(bzds): 업권
  // companyName(cmpyNm): 회사명
  // mpType(mpTp): mp유형

  final String? baseDate;
  final String? businessDomain;
  final String? mpType;
  final List<IsaMpBenefitRateOption> options;

  IsaMpBenefitRate({
    // CommonInfo
    required ProductCategory category,
    required String? companyName,
    required String? mpName,
    required String? releaseDate,
    required bool isLiked,

    required this.baseDate,
    required this.businessDomain,
    required this.mpType,
    required this.options,
  }) : super(
         CommonInfo(
           category: category,
           companyName: companyName,
           productName: mpName,
           submittedDay: releaseDate,
           isLiked: isLiked,
         ),
       );

  @override
  FinancialProduct copyWith(bool isLiked) {
    return IsaMpBenefitRate(
      isLiked: isLiked,
      category: commonInfo.category,
      companyName: commonInfo.companyName,
      mpName: commonInfo.productName,
      releaseDate: commonInfo.submittedDay,
      baseDate: baseDate,
      businessDomain: businessDomain,
      mpType: mpType,
      options: options,
    );
  }
}
