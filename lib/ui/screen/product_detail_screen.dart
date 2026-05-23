import 'package:finbrain/data/model/entities/annuity_savings.dart';
import 'package:finbrain/data/model/entities/credit_loan.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/model/entities/isa_mp_benefit_rate.dart';
import 'package:finbrain/data/model/entities/mortage_and_rent_loan.dart';
import 'package:finbrain/provider/product_provider.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/product_categories.dart';
import 'package:finbrain/ui/screen/calculator_screen.dart';
import 'package:finbrain/ui/widget/ai_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({
    super.key,
    required this.productName,
    required this.category,
  });

  final String productName;
  final ProductCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref
        .watch(productProvider)
        .firstWhere((p) => p.commonInfo.productName == productName);

    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primary100,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new, color: textPrimary),
        ),
        title: Text(
          productName,
          style: TextStyle(
            color: textPrimary,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        titleSpacing: -6.0,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(productProvider.notifier).toggleLiked(productName);
            },
            icon: product.commonInfo.isLiked
                ? const Icon(Icons.favorite, color: likedColor, size: 32.0)
                : const Icon(Icons.favorite, color: unlikedColor, size: 32.0),
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24.0,
                    horizontal: 20.0,
                  ),
                  child: Column(
                    children: [
                      ..._displayDefaultWidgetList(product),
                      ..._displayDynamicWidgetList(category, product),
                      SizedBox(height: 40.0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(right: 20, bottom: 100, child: const AiButton()),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) =>
                                CalculatorScreen(category: category),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        color: primary300,
                        alignment: Alignment.center,
                        child: Text(
                          "금융 계산기",
                          style: TextStyle(
                            color: textPrimary,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      color: primary100,
                      alignment: Alignment.center,
                      child: Text(
                        "공식 홈페이지로 이동",
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textFrame(String? text) {
    return Text(
      (text == null) ? "제공 안 함" : text,
      style: const TextStyle(
        color: black,
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  List<Widget> _displayDefaultWidgetList(FinancialProduct product) {
    return [
      const Text(
        "상품 안내",
        style: TextStyle(
          color: textPrimary,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      const Divider(thickness: 1, color: black),
      textFrame("금융 상품명: ${product.commonInfo.productName}"),
      textFrame("금융회사: ${product.commonInfo.companyName}"),
    ];
  }

  List<Widget> _displayDynamicWidgetList(
    ProductCategory category,
    FinancialProduct product,
  ) {
    return [
      if (category != ProductCategory.isa)
        textFrame("가입 방법: ${product.commonInfo.joinWay}"),
      if (category == ProductCategory.deposit ||
          category == ProductCategory.installment) ...[
        textFrame("가입 제한: ${(product as DepositAndInstallmentSavings).joinDeny}"),
        textFrame("가입 대상: ${product.joinMember}"),
      ] else if (category == ProductCategory.credit) ...[
        textFrame("CB 회사: ${(product as CreditLoan).cbName}"),
        textFrame("대출 종류 ${product.productTypeName}"),
      ] else if (category == ProductCategory.annuity) ...[
        textFrame("연금 종류: ${(product as AnnuitySavings).pensionKindName}"),
        textFrame("상품 유형: ${product.productTypeName}"),
        textFrame("판매사: ${product.saleCompany}"),
        textFrame("판매사: ${product.saleCompany}"),
      ] else if (category == ProductCategory.isa) ...[
        textFrame("업권: ${(product as IsaMpBenefitRate).businessDomain}"),
        textFrame("mp유형: ${product.mpType}"),
      ] else
        ...[],
      textFrame(product.commonInfo.submittedDay),
      SizedBox(height: 14.0),
      Text(
        switch (category) {
          ProductCategory.credit => "대출 금리 안내",
          ProductCategory.annuity => "상품 공시 현황",
          ProductCategory.isa => "수익률",
          _ => "상품 세부사항",
        },
        style: TextStyle(
          color: textPrimary,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      const Divider(thickness: 1, color: black),
      if (category == ProductCategory.deposit ||
          category == ProductCategory.installment) ...[
        textFrame("만기 후 이자율:\n${(product as DepositAndInstallmentSavings).interestAfterExpiration}"),
        const SizedBox(height: 14.0,),
        textFrame("우대 조건:\n${product.specialCondition}"),
        const SizedBox(height: 14.0,),
        textFrame("기타 유의 사항:\n${product.etc}"),
        // todo: 옵션에서 리스트 호출해 제시
      ] else if (category == ProductCategory.mortage || category == ProductCategory.rent) ...[
        textFrame("대출 부대 비용:\n${(product as MortageAndRentLoan).extraExpense}"),
        const SizedBox(height: 14.0,),
        textFrame("중도 상환 수수료:\n${product.earlyRepayFee}"),
        const SizedBox(height: 14.0,),
        textFrame("연체 이자율:\n${product.delayRate}"),
        const SizedBox(height: 14.0,),
        textFrame("대출 한도: ${product.loanLimit}"),
        // todo: 상환 방식에 따른 내용 추가(options)
        // todo: 신용 등금에 따른 이자 추가(options)
      ] else if (category == ProductCategory.credit)Table()
      else if (category == ProductCategory.annuity) ...[
        textFrame("유지건수/설정액 ${(product as AnnuitySavings).maintenanceCount}"),
        textFrame("평균 수익률: ${product.averageCommision}"),
        textFrame("공시 이율: ${product.declaredRate}"),
        textFrame("최저 보증 이율: ${product.guaranteedRate}"),
        textFrame("전년도 수익률: ${product.pyProfitRate}"),
        textFrame("전전년도 수익률: ${product.ppyProfitRate}"),
        textFrame("전전전년도 수익률: ${product.pppyProfitRate}"),
      ]
      // todo: isa
      else Table(),
    ];
  }
}
