import 'package:finbrain/data/model/entities/annuity_savings.dart';
import 'package:finbrain/data/model/entities/credit_loan.dart';
import 'package:finbrain/data/model/entities/credit_loan_option.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings_option.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/model/entities/isa_mp_benefit_rate.dart';
import 'package:finbrain/data/model/entities/isa_mp_benefit_rate_option.dart';
import 'package:finbrain/data/model/entities/mortage_and_rent_loan.dart';
import 'package:finbrain/data/model/entities/mortage_and_rent_loan_option.dart';
import 'package:finbrain/ui/viewmodel/product_detail_screen_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/calculator_screen.dart';
import 'package:finbrain/ui/widget/ai_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.productCategory,
    required this.filterCategory,
  });

  final FinancialProduct product;
  final ProductCategory productCategory;
  final FilterTextCategory filterCategory;

  void launchPrdtUrl(WidgetRef ref, BuildContext context) {
    ref
        .read(productDetailScreenViewmodelProvider.notifier)
        .fetchAndOpenProductUrl(
          product.commonInfo.companyName!,
          product.commonInfo.productName!,
        )
        .then((isSuccess) {
          if (!isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 3),
                content: const Text("오류: 외부 url으로의 이동이 실패했습니다, 다시 시도해주세요"),
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primary100,
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new, color: textPrimary),
        ),
        title: Text(
          product.commonInfo.productName!,
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
              ref.read(productViewmodelProvider.notifier).toggleLiked(product);
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._displayDefaultWidgetList(product),
                      ..._displayDynamicWidgetList(productCategory, product),
                      SizedBox(height: 160.0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 100,
              child: AiButton(tag: product.commonInfo.productName!),
            ),
            if (productCategory == ProductCategory.isa)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () => launchPrdtUrl(ref, context),
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
              )
            else
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
                              builder: (ctx) {
                                final options = switch (productCategory) {
                                  ProductCategory.deposit =>
                                    (product as DepositAndInstallmentSavings)
                                        .options,
                                  ProductCategory.installment =>
                                    (product as DepositAndInstallmentSavings)
                                        .options,
                                  ProductCategory.credit =>
                                    (product as CreditLoan).options,
                                  ProductCategory.annuity =>
                                    (product as AnnuitySavings).options,
                                  _ => (product as MortageAndRentLoan).options,
                                };
                                return CalculatorScreen(
                                  category: productCategory,
                                  mapOptions: ref
                                      .read(
                                        productDetailScreenViewmodelProvider
                                            .notifier,
                                      )
                                      .mapProductOptions(
                                        productCategory,
                                        options,
                                      ),
                                  options: options,
                                );
                              },
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
                      child: GestureDetector(
                        onTap: () => launchPrdtUrl(ref, context),
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
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget textFrame(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: black,
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget tableCellFrame(String text) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(child: textFrame(text)),
      ),
    );
  }

  Widget dataTableCellText(String text) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: black,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget tableFrame(ProductCategory category, List<dynamic> options) {
    if (category == ProductCategory.credit) {
      return Column(
        children: [
          for (final option in options as List<CreditLoanOption>)
            if (option.creditLendRateTypeName != null) ...[
              textFrame(option.creditLendRateTypeName!),
              const SizedBox(height: 8.0),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(color: primary300),
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: primary100,
                      border: BoxBorder.all(color: primary300),
                    ),
                    children: [
                      tableCellFrame("신용 등급"),
                      tableCellFrame("대출 금리"),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableCellFrame("900점 초과"),
                      tableCellFrame(option.gradeOver900.toString()),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableCellFrame("801~900점"),
                      tableCellFrame(option.grade801900.toString()),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableCellFrame("701~800점"),
                      tableCellFrame(option.grade701800.toString()),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableCellFrame("601~700점"),
                      tableCellFrame((option.grade601700.toString())),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableCellFrame(("501~600점")),
                      tableCellFrame((option.grade501600.toString())),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableCellFrame(("401~500점")),
                      tableCellFrame((option.grade401500.toString())),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableCellFrame(("301~400점")),
                      tableCellFrame((option.grade301400.toString())),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableCellFrame(("300점 이하")),
                      tableCellFrame((option.gradeUnder300.toString())),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableCellFrame(("평균 금리")),
                      tableCellFrame((option.averageGrade.toString())),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 28.0),
            ],
        ],
      );
    } else {
      return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: primary300),
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: primary100,
              border: BoxBorder.all(color: primary300),
            ),
            children: [tableCellFrame("기간"), tableCellFrame("수익률")],
          ),
          for (final option in options as List<IsaMpBenefitRateOption>) ...[
            if (option.term != null && option.benefitRate != null)
              TableRow(
                children: [
                  tableCellFrame(option.term!),
                  tableCellFrame(option.benefitRate.toString()),
                ],
              ),
          ],
        ],
      );
    }
  }

  Widget dataTableFrame(
    ProductCategory category,
    List<String> columns,
    List<dynamic> options,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        decoration: BoxDecoration(border: Border.all(color: primary300)),
        headingRowColor: const WidgetStatePropertyAll(primary100),
        headingRowHeight: 40.0,
        dataRowColor: const WidgetStatePropertyAll(white),
        columnSpacing: 36.0,
        columns: [
          for (final column in columns)
            DataColumn(
              label: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [dataTableCellText(column)],
                ),
              ),
            ),
        ],
        rows: [
          if (category == ProductCategory.deposit)
            for (final option
                in options as List<DepositAndInstallmentSavingsOption>)
              DataRow(
                cells: [
                  DataCell(
                    dataTableCellText(option.intRateTypeName.toString()),
                  ),
                  DataCell(dataTableCellText(option.saveTerm.toString())),
                  DataCell(dataTableCellText(option.intRate.toString())),
                  DataCell(dataTableCellText(option.maxIntRate.toString())),
                ],
              ),
          if (category == ProductCategory.installment)
            for (final option
                in options as List<DepositAndInstallmentSavingsOption>)
              DataRow(
                cells: [
                  DataCell(dataTableCellText(option.intRateTypeName!)),
                  DataCell(
                    dataTableCellText(option.reserveTypeName.toString()),
                  ),
                  DataCell(dataTableCellText(option.saveTerm.toString())),
                  DataCell(dataTableCellText(option.intRate.toString())),
                  DataCell(dataTableCellText(option.maxIntRate.toString())),
                ],
              ),
          if (category == ProductCategory.mortage)
            for (final option in options as List<MortageAndRentLoanOption>)
              DataRow(
                cells: [
                  DataCell(dataTableCellText(option.loanTypeName!)),
                  DataCell(dataTableCellText(option.repayTypeName!)),
                  DataCell(dataTableCellText(option.lendRateTypeName!)),
                  DataCell(dataTableCellText(option.lendRateMin.toString())),
                  DataCell(dataTableCellText(option.lendRateMax.toString())),
                  DataCell(dataTableCellText(option.lendRateAvg.toString())),
                ],
              ),
          if (category == ProductCategory.rent)
            for (final option in options as List<MortageAndRentLoanOption>)
              DataRow(
                cells: [
                  DataCell(dataTableCellText(option.repayTypeName!)),
                  DataCell(dataTableCellText(option.lendRateTypeName!)),
                  DataCell(dataTableCellText(option.lendRateMin.toString())),
                  DataCell(dataTableCellText(option.lendRateMax.toString())),
                  DataCell(dataTableCellText(option.lendRateAvg.toString())),
                ],
              ),
        ],
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
      const Divider(thickness: 1, color: textPrimary),
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
        textFrame(
          "가입 방법: ${(product.commonInfo.joinWay == null) ? "미제공" : product.commonInfo.joinWay!.join(",")}",
        ),
      if (category == ProductCategory.deposit ||
          category == ProductCategory.installment) ...[
        textFrame(
          "가입 제한: ${((product as DepositAndInstallmentSavings).joinDeny == null) ? "미제공" : product.joinDeny}",
        ),
        textFrame(
          "가입 대상: ${(product.joinMember == null) ? "미제공" : product.joinMember}",
        ),
      ] else if (category == ProductCategory.credit) ...[
        textFrame(
          "CB 회사: ${((product as CreditLoan).cbName == null) ? "미제공" : product.cbName}",
        ),
        textFrame(
          "대출 종류 ${(product.productTypeName == null) ? "미제공" : product.productTypeName}",
        ),
      ] else if (category == ProductCategory.annuity) ...[
        textFrame(
          "연금 종류: ${((product as AnnuitySavings).pensionKindName == null) ? "미제공" : product.pensionKindName}",
        ),
        textFrame(
          "상품 유형: ${(product.productTypeName == null) ? "미제공" : product.productTypeName}",
        ),
        textFrame(
          "판매사: ${(product.saleCompany == null) ? "미제공" : product.saleCompany}",
        ),
      ] else if (category == ProductCategory.isa) ...[
        textFrame(
          "업권: ${((product as IsaMpBenefitRate).businessDomain == null) ? "미제공" : product.businessDomain}",
        ),
        textFrame("mp유형: ${(product.mpType == null) ? "미제공" : product.mpType}"),
      ] else
        ...[],
      textFrame("공시 제출일: ${product.commonInfo.submittedDay}"),
      SizedBox(height: 24.0),
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
      const Divider(thickness: 1, color: textPrimary),
      const SizedBox(height: 14.0),
      if (category == ProductCategory.deposit ||
          category == ProductCategory.installment) ...[
        textFrame("금리"),
        dataTableFrame(
          category,
          (category == ProductCategory.deposit)
              ? const ["금리 유형", "기간(개월)", "기본 금리", "최고 우대 금리"]
              : const ["금리 유형", "적금 유형", "기간(개월)", "금리", "최고 우대 금리"],
          (product as DepositAndInstallmentSavings).options,
        ),
        const SizedBox(height: 14.0),
        textFrame(
          "만기 후 이자율:\n${(product.interestAfterExpiration == null) ? "미제공" : product.interestAfterExpiration}",
        ),
        const SizedBox(height: 14.0),
        textFrame(
          "우대 조건:\n${(product.specialCondition == null) ? "미제공" : product.specialCondition}",
        ),
        const SizedBox(height: 14.0),
        textFrame("기타 유의 사항:\n${(product.etc == null) ? "미제공" : product.etc}"),
      ] else if (category == ProductCategory.mortage ||
          category == ProductCategory.rent) ...[
        textFrame("금리"),
        const SizedBox(height: 14.0),
        dataTableFrame(
          category,
          (category == ProductCategory.mortage)
              ? const [
                  "담보 유형",
                  "대출 상환 유형",
                  "대출 금리 유형",
                  "최저 금리",
                  "최대 금리",
                  "평균 금리",
                ]
              : const ["대출 상환 유형", "대출 금리 유형", "최저 금리", "최대 금리", "평균 금리"],
          (product as MortageAndRentLoan).options,
        ),
        const SizedBox(height: 14.0),
        textFrame(
          "대출 부대 비용:\n${(product.extraExpense == null) ? "미제공" : product.extraExpense}",
        ),
        const SizedBox(height: 14.0),
        textFrame(
          "중도 상환 수수료:\n${(product.earlyRepayFee == null) ? "미제공" : product.earlyRepayFee}",
        ),
        const SizedBox(height: 14.0),
        textFrame(
          "연체 이자율:\n${(product.delayRate == null) ? "미제공" : product.delayRate}",
        ),
        const SizedBox(height: 14.0),
        textFrame(
          "대출 한도: ${(product.loanLimit == null) ? "미제공" : product.loanLimit}",
        ),
      ] else if (category == ProductCategory.credit)
        tableFrame(category, (product as CreditLoan).options)
      else if (category == ProductCategory.annuity) ...[
        textFrame(
          "유지건수/설정액 ${((product as AnnuitySavings).maintenanceCount == null) ? "미제공" : product.maintenanceCount}",
        ),
        textFrame(
          "평균 수익률: ${(product.averageProfit == null) ? "미제공" : product.averageProfit}",
        ),
        textFrame(
          "공시 이율: ${(product.declaredRate == null) ? "미제공" : product.declaredRate}",
        ),
        textFrame(
          "최저 보증 이율: ${(product.guaranteedRate == null) ? "미제공" : product.guaranteedRate}",
        ),
        textFrame(
          "전년도 수익률: ${(product.pyProfitRate == null) ? "미제공" : product.pyProfitRate}",
        ),
        textFrame(
          "전전년도 수익률: ${(product.ppyProfitRate == null) ? "미제공" : product.ppyProfitRate}",
        ),
        textFrame(
          "전전전년도 수익률: ${(product.pppyProfitRate == null) ? "미제공" : product.pppyProfitRate}",
        ),
      ] else
        tableFrame(category, (product as IsaMpBenefitRate).options),
    ];
  }
}
