import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/product_categories.dart';
import 'annuity_savings_option.dart';

// 연금저축
class AnnuitySavings extends FinancialProduct {
  // 프로퍼티명(필드명): 의미
  // commonInfo: 기본 정보
  // pensionKind(pnsn_kind): 연금 종류
  // pensionKindName(pnsn_kind_nm): 연금 종류명
  // saleStartDay(sale_strt_day): 판매 개시일
  // maintenanceCount(mtnt_cnt): 유지건수/설정액
  // productType(prdt_type): 상품 유형
  // productTypeName(prdt_type_nm): 상품 유형명
  // averageProfit(avg_prft_rate): 평균 수익률
  // declaredRate(dcls_rate): 공시 이율
  // guaranteedRate(guar_rate): 최저 보증 이율
  // pyProfitRate(brtm_prft_rate1): 전년도 수익률
  // ppyProfitRate(brtm_prft_rate2): 전전년도 수익률
  // ppyProfitRate(brtm_prft_rate3): 전전전년도수 익률
  // etc(etc): 기타사항
  // saleCompany(sale_co): 판매사
  // options: 옵션 목록

  final String? pensionKind;
  final String? pensionKindName;
  final String? saleStartDay;
  final String? maintenanceCount;
  final String? productType;
  final String? productTypeName;
  final double? averageProfit;
  final String? declaredRate;
  final String? guaranteedRate;
  final double? pyProfitRate;
  final double? ppyProfitRate;
  final double? pppyProfitRate;
  final String? etc;
  final String? saleCompany;
  final List<AnnuitySavingsOption> options;

  AnnuitySavings({
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
    required List<String>? joinWay,
    required bool isLiked,

    required this.pensionKind,
    required this.pensionKindName,
    required this.saleStartDay,
    required this.maintenanceCount,
    required this.productType,
    required this.productTypeName,
    required this.averageProfit,
    required this.declaredRate,
    required this.guaranteedRate,
    required this.pyProfitRate,
    required this.ppyProfitRate,
    required this.pppyProfitRate,
    required this.etc,
    required this.saleCompany,
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
           isLiked: isLiked,
         ),
       );

  @override
  FinancialProduct copyWith(bool isLiked) {
    return AnnuitySavings(
      isLiked: isLiked,
      category: commonInfo.category,
      submittedMonth: commonInfo.submittedMonth,
      companyCode: commonInfo.companyCode,
      companyName: commonInfo.companyName,
      productCode: commonInfo.productCode,
      productName: commonInfo.productName,
      startDay: commonInfo.startDay,
      endDay: commonInfo.endDay,
      submittedDay: commonInfo.submittedDay,
      joinWay: commonInfo.joinWay,
      pensionKind: pensionKind,
      pensionKindName: pensionKindName,
      saleStartDay: saleStartDay,
      maintenanceCount: maintenanceCount,
      productType: productType,
      productTypeName: productTypeName,
      averageProfit: averageProfit,
      declaredRate: declaredRate,
      guaranteedRate: guaranteedRate,
      pyProfitRate: pyProfitRate,
      ppyProfitRate: ppyProfitRate,
      pppyProfitRate: pppyProfitRate,
      etc: etc,
      saleCompany: saleCompany,
      options: options,
    );
  }

  @override
  Map<String, Object> toMap() {
    return {
      "isLiked": true,
      "category": "${commonInfo.category}",
      "submittedMonth": "${commonInfo.submittedMonth}",
      "companyCode": "${commonInfo.companyCode}",
      "companyName": "${commonInfo.companyName}",
      "productCode": "${commonInfo.productCode}",
      "productName": "${commonInfo.productName}",
      "startDay": "${commonInfo.startDay}",
      "endDay": "${commonInfo.endDay}",
      "submittedDay": "${commonInfo.submittedDay}",
      "joinWay": commonInfo.joinWay ?? [],
      "pensionKind": "$pensionKind",
      "pensionKindName": "$pensionKindName",
      "saleStartDay": "$saleStartDay",
      "maintenanceCount": "$maintenanceCount",
      "productType": "$productType",
      "productTypeName": "$productTypeName",
      "averageProfit": "$averageProfit",
      "declaredRate": "$declaredRate",
      "guaranteedRate": "$guaranteedRate",
      "pyProfitRate": "$pyProfitRate",
      "ppyProfitRate": "$ppyProfitRate",
      "pppyProfitRate": "$pppyProfitRate",
      "etc": "$etc",
      "saleCompany": "$saleCompany",
      "options": options
          .map(
            (e) => {
              "receiptTerm": e.receiptTerm,
              "receiptTermName": e.receiptTermName,
              "entryAge": e.entryAge,
              "entryAgeName": e.entryAgeName,
              "monthlyPayment": e.monthlyPayment,
              "monthlyPaymentName": e.monthlyPaymentName,
              "paymentPeriod": e.paymentPeriod,
              "paymentPeriodName": e.paymentPeriodName,
              "startAge": e.startAge,
              "startAgeName": e.startAgeName,
              "monthlyReceiptAmount": e.monthlyReceiptAmount,
            },
          )
          .toList(),
    };
  }

  List<double> returnProfits() {
    return [
      averageProfit ?? -double.maxFinite,
      pyProfitRate ?? -double.maxFinite,
      ppyProfitRate ?? -double.maxFinite,
      pppyProfitRate ?? -double.maxFinite,
    ];
  }
}
