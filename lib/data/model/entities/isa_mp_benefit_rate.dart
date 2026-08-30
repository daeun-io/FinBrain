import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/model/entities/isa_mp_benefit_rate_option.dart';
import 'package:finbrain/product_categories.dart';

// ISA MP 대표수익률
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
  final double? avgProfit;
  final double? medProfit;
  final List<IsaMpBenefitRateOption> options;

  IsaMpBenefitRate({
    // CommonInfo
    required ProductCategory category,
    required String? companyName,
    required String? productName,
    required String? releaseDate,
    required bool isLiked,

    required this.baseDate,
    required this.businessDomain,
    required this.mpType,
    required this.options,
    required this.avgProfit,
    required this.medProfit
  }) : super(
         CommonInfo(
           category: category,
           companyName: companyName,
           productName: productName,
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
      productName: commonInfo.productName,
      releaseDate: commonInfo.submittedDay,
      baseDate: baseDate,
      businessDomain: businessDomain,
      mpType: mpType,
      avgProfit: avgProfit,
      medProfit: medProfit,
      options: options,
    );
  }

  @override
  Map<String, Object> toMap() {
    return {
      "isLiked": true,
      "category": commonInfo.category.toString(),
      "companyName": commonInfo.companyName.toString(),
      "productName": commonInfo.productName.toString(),
      "releaseDate": commonInfo.submittedDay.toString(),
      "baseDate": baseDate.toString(),
      "businessDomain": businessDomain.toString(),
      "mpType": mpType.toString(),
      "avgProfit": avgProfit ?? "null",
      "medProfit": medProfit ?? "null",
      "options": options
          .map((e) => {"term": e.term, "benefitRate": e.benefitRate})
          .toList(),
    };
  }
}
