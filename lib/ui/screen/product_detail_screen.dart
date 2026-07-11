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
import 'package:finbrain/themes/text_style.dart';
import 'package:finbrain/ui/viewmodel/liked_product_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/product_detail_screen_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/calculator_screen.dart';
import 'package:finbrain/ui/widget/ai_button.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/showing_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({
    super.key,
    required this.productName,
    required this.fromLikedScreen,
  });
  final String productName;
  final bool fromLikedScreen;

  void launchPrdtUrl(
    WidgetRef ref,
    BuildContext context,
    ColorScheme colorScheme,
    String companyName,
  ) {
    ref
        .read(productDetailScreenViewmodelProvider.notifier)
        .fetchAndOpenProductUrl(companyName, productName)
        .then((isSuccess) {
          if (!isSuccess) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: colorScheme.scrim,
                duration: Duration(seconds: 3),
                content: Text(
                  "오류: 외부 url으로의 이동이 실패했습니다, 다시 시도해주세요",
                  style: bodyRgSm.copyWith(color: colorScheme.onSecondary),
                ),
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final productList = ref.watch(productViewmodelProvider);
    final likedList = ref.watch(likedProductViewmodelProvider);

    return ((fromLikedScreen) ? likedList : productList).when(
      data: (data) {
        final product =
            ((fromLikedScreen)
                    ? data as List<FinancialProduct>
                    : (data as (int, List<FinancialProduct>)).$2)
                .where((e) => e.commonInfo.productName == productName)
                .firstOrNull;

        if (product == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          });
          return const Scaffold(
            backgroundColor: white,
            body: SizedBox.shrink(),
          );
        }

        return Scaffold(
          backgroundColor: colorScheme.primary,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: colorScheme.tertiary,
            scrolledUnderElevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: colorScheme.onPrimary,
              ),
            ),
            title: Text(
              productName.replaceAll(r'\\n', ""),
              style: headingMd.copyWith(color: colorScheme.onPrimary),
            ),
            titleSpacing: -6.0,
            actions: [
              IconButton(
                onPressed: () {
                  ref
                      .read(productViewmodelProvider.notifier)
                      .toggleLiked(product);
                },
                icon: product.commonInfo.isLiked
                    ? Icon(
                        Icons.favorite,
                        color: colorScheme.onPrimaryFixed,
                        size: 28.0,
                      )
                    : Icon(
                        Icons.favorite,
                        color: colorScheme.onPrimaryFixedVariant,
                        size: 28.0,
                      ),
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
                          ..._displayDefaultWidgetList(product, colorScheme),
                          ..._displayDynamicWidgetList(
                            product.commonInfo.category,
                            product,
                            colorScheme,
                          ),
                          SizedBox(height: 160.0),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 100,
                  child: AiButton(
                    tag: product.commonInfo.productName!,
                    category: product.commonInfo.category,
                  ),
                ),
                if (product.commonInfo.category == ProductCategory.isaMp)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () => launchPrdtUrl(
                        ref,
                        context,
                        colorScheme,
                        product.commonInfo.companyName ?? "",
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        decoration: BoxDecoration(
                          color: colorScheme.secondary,
                          border: Border.all(
                            color: colorScheme.outline,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.ads_click,
                              color: colorScheme.onSecondary,
                              size: 24.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              "공식 홈페이지로 이동",
                              style: bodySbLg.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            ),
                          ],
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
                                    final options = switch (product
                                        .commonInfo
                                        .category) {
                                      ProductCategory.deposit =>
                                        (product
                                                as DepositAndInstallmentSavings)
                                            .options,
                                      ProductCategory.installment =>
                                        (product
                                                as DepositAndInstallmentSavings)
                                            .options,
                                      ProductCategory.credit =>
                                        (product as CreditLoan).options,
                                      ProductCategory.annuity =>
                                        (product as AnnuitySavings).options,
                                      _ =>
                                        (product as MortageAndRentLoan).options,
                                    };
                                    return CalculatorScreen(
                                      category: product.commonInfo.category,
                                      mapOptions: ref
                                          .read(
                                            productDetailScreenViewmodelProvider
                                                .notifier,
                                          )
                                          .mapProductOptions(
                                            product.commonInfo.category,
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
                              decoration: BoxDecoration(
                                color: colorScheme.secondary,
                                border: Border.all(
                                  color: colorScheme.outline,
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calculate_outlined,
                                    color: colorScheme.onSecondary,
                                    size: 24.0,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    "금융 계산기",
                                    style: bodySbLg.copyWith(
                                      color: colorScheme.onSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => launchPrdtUrl(
                              ref,
                              context,
                              colorScheme,
                              product.commonInfo.companyName ?? "",
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                              decoration: BoxDecoration(
                                color: colorScheme.secondary,
                                border: Border.all(
                                  color: colorScheme.outline,
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.ads_click,
                                    color: colorScheme.onSecondary,
                                    size: 24.0,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    "공식 홈페이지로 이동",
                                    style: bodySbLg.copyWith(
                                      color: colorScheme.onSecondary,
                                    ),
                                  ),
                                ],
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
      },
      error: (err, stack) => const ShowingErrorWidget(),
      loading: () => const CustomProgressIndicator(),
    );
  }

  Widget textFrame(String text, Color color) {
    return Text(
      text,
      style: bodyRgMd.copyWith(color: color),
    );
  }

  Widget tableCellFrame(String text, Color color) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(child: textFrame(text, color)),
      ),
    );
  }

  Widget dataTableCellText(String text, Color color) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: bodyRgMd.copyWith(color: color),
      ),
    );
  }

  Widget tableFrame(
    ProductCategory category,
    List<dynamic> options,
    ColorScheme colorScheme,
  ) {
    if (category == ProductCategory.credit) {
      return Column(
        children: [
          for (final option in options as List<CreditLoanOption>)
            if (option.creditLendRateTypeName != null) ...[
              textFrame(
                option.creditLendRateTypeName!,
                colorScheme.onSecondary,
              ),
              const SizedBox(height: 8.0),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(color: colorScheme.outline),
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: colorScheme.secondary,
                      border: BoxBorder.all(color: colorScheme.outline),
                    ),
                    children: [
                      tableCellFrame("신용 등급", colorScheme.onSecondary),
                      tableCellFrame("대출 금리", colorScheme.onSecondary),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableCellFrame("900점 초과", colorScheme.onSecondary),
                      tableCellFrame(
                        (option.gradeOver900 == null)
                            ? "미제공"
                            : option.gradeOver900.toString(),
                        colorScheme.onSecondary,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableCellFrame("801~900점", colorScheme.onSecondary),
                      tableCellFrame(
                        (option.grade801900 == null)
                            ? "미제공"
                            : option.grade801900.toString(),
                        colorScheme.onSecondary,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableCellFrame("701~800점", colorScheme.onSecondary),
                      tableCellFrame(
                        (option.grade701800 == null)
                            ? "미제공"
                            : option.grade701800.toString(),
                        colorScheme.onSecondary,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableCellFrame("601~700점", colorScheme.onSecondary),
                      tableCellFrame(
                        (option.grade601700 == null)
                            ? "미제공"
                            : option.grade601700.toString(),
                        colorScheme.onSecondary,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableCellFrame("501~600점", colorScheme.onSecondary),
                      tableCellFrame(
                        (option.grade501600 == null)
                            ? "미제공"
                            : option.grade501600.toString(),
                        colorScheme.onSecondary,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableCellFrame("401~500점", colorScheme.onSecondary),
                      tableCellFrame(
                        (option.grade401500 == null)
                            ? "미제공"
                            : option.grade401500.toString(),
                        colorScheme.onSecondary,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableCellFrame("301~400점", colorScheme.onSecondary),
                      tableCellFrame(
                        (option.grade301400 == null)
                            ? "미제공"
                            : option.grade301400.toString(),
                        colorScheme.onSecondary,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableCellFrame("300점 이하", colorScheme.onSecondary),
                      tableCellFrame(
                        (option.gradeUnder300 == null)
                            ? "미제공"
                            : option.gradeUnder300.toString(),
                        colorScheme.onSecondary,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableCellFrame("평균 금리", colorScheme.onSecondary),
                      tableCellFrame(
                        (option.averageGrade == null)
                            ? "미제공"
                            : option.averageGrade.toString(),
                        colorScheme.onSecondary,
                      ),
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
        border: TableBorder.all(color: colorScheme.outline),
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: colorScheme.secondary,
              border: BoxBorder.all(color: colorScheme.outline),
            ),
            children: [
              tableCellFrame("기간", colorScheme.onSecondary),
              tableCellFrame("수익률", colorScheme.onSecondary),
            ],
          ),
          for (final option in options as List<IsaMpBenefitRateOption>) ...[
            if (option.term != null && option.benefitRate != null)
              TableRow(
                children: [
                  tableCellFrame(option.term!, colorScheme.onSecondary),
                  tableCellFrame(
                    (option.benefitRate == null)
                        ? "미제공"
                        : option.benefitRate.toString(),
                    colorScheme.onSecondary,
                  ),
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
    ColorScheme colorScheme,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Theme(
        data: ThemeData(useMaterial3: false, dividerColor: colorScheme.outline),
        child: DataTable(
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.outline),
          ),
          headingRowColor: WidgetStatePropertyAll(colorScheme.secondary),
          headingRowHeight: 40.0,
          dataRowColor: WidgetStatePropertyAll(colorScheme.surface),
          columnSpacing: 36.0,
          columns: [
            for (final column in columns)
              DataColumn(
                label: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      dataTableCellText(column, colorScheme.onSecondary),
                    ],
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
                      dataTableCellText(
                        option.intRateTypeName ?? "미제공",
                        colorScheme.onSecondary,
                      ),
                    ),
                    DataCell(
                      dataTableCellText(
                        (option.saveTerm == null)
                            ? "미제공"
                            : option.saveTerm.toString(),
                        colorScheme.onSecondary,
                      ),
                    ),
                    DataCell(
                      dataTableCellText(
                        (option.intRate == null)
                            ? "미제공"
                            : option.intRate.toString(),
                        colorScheme.onSecondary,
                      ),
                    ),
                    DataCell(
                      dataTableCellText(
                        (option.maxIntRate == null)
                            ? "미제공"
                            : option.maxIntRate.toString(),
                        colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
            if (category == ProductCategory.installment)
              for (final option
                  in options as List<DepositAndInstallmentSavingsOption>)
                DataRow(
                  cells: [
                    DataCell(
                      dataTableCellText(
                        option.intRateTypeName ?? "미제공",
                        colorScheme.onSecondary,
                      ),
                    ),
                    DataCell(
                      dataTableCellText(
                        option.reserveTypeName ?? "미제공",
                        colorScheme.onSecondary,
                      ),
                    ),
                    DataCell(
                      dataTableCellText(
                        (option.saveTerm == null)
                            ? "미제공"
                            : option.saveTerm.toString(),
                        colorScheme.onSecondary,
                      ),
                    ),
                    DataCell(
                      dataTableCellText(
                        (option.intRate == null)
                            ? "미제공"
                            : option.intRate.toString(),
                        colorScheme.onSecondary,
                      ),
                    ),
                    DataCell(
                      dataTableCellText(
                        (option.maxIntRate == null)
                            ? "미제공"
                            : option.maxIntRate.toString(),
                        colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
            if (category == ProductCategory.mortgage)
              for (final option in options as List<MortageAndRentLoanOption>)
                DataRow(
                  cells: [
                    DataCell(
                      dataTableCellText(
                        option.loanTypeName ?? "미제공",
                        colorScheme.onSecondary,
                      ),
                    ),
                    DataCell(
                      dataTableCellText(
                        option.repayTypeName ?? "미제공",
                        colorScheme.onSecondary,
                      ),
                    ),
                    DataCell(
                      dataTableCellText(
                        option.lendRateTypeName ?? "미제공",
                        colorScheme.onSecondary,
                      ),
                    ),
                    DataCell(
                      dataTableCellText(
                        (option.lendRateMin == null)
                            ? "미제공"
                            : option.lendRateMin.toString(),
                        colorScheme.onSecondary,
                      ),
                    ),
                    DataCell(
                      dataTableCellText(
                        (option.lendRateMax == null)
                            ? "미제공"
                            : option.lendRateMax.toString(),
                        colorScheme.onSecondary,
                      ),
                    ),
                    DataCell(
                      dataTableCellText(
                        (option.lendRateAvg == null)
                            ? "미제공"
                            : option.lendRateAvg.toString(),
                        colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
            if (category == ProductCategory.rent)
              for (final option in options as List<MortageAndRentLoanOption>)
                DataRow(
                  cells: [
                    DataCell(
                      dataTableCellText(
                        option.repayTypeName ?? "미제공",
                        colorScheme.onSecondary,
                      ),
                    ),
                    DataCell(
                      dataTableCellText(
                        option.lendRateTypeName ?? "미제공",
                        colorScheme.onSecondary,
                      ),
                    ),
                    DataCell(
                      dataTableCellText(
                        (option.lendRateMin == null)
                            ? "미제공"
                            : option.lendRateMin.toString(),
                        colorScheme.onSecondary,
                      ),
                    ),
                    DataCell(
                      dataTableCellText(
                        (option.lendRateMax == null)
                            ? "미제공"
                            : option.lendRateMax.toString(),
                        colorScheme.onSecondary,
                      ),
                    ),
                    DataCell(
                      dataTableCellText(
                        (option.lendRateAvg == null)
                            ? "미제공"
                            : option.lendRateAvg.toString(),
                        colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }

  List<Widget> _displayDefaultWidgetList(
    FinancialProduct product,
    ColorScheme colorScheme,
  ) {
    return [
      Text(
        "상품 안내",
        style: bodySbLg.copyWith(color: colorScheme.onPrimary),
      ),
      Divider(thickness: 1, color: colorScheme.onSecondary),
      textFrame(
        "금융 상품명: ${product.commonInfo.productName}",
        colorScheme.onSecondary,
      ),
      textFrame(
        "금융회사: ${product.commonInfo.companyName}",
        colorScheme.onSecondary,
      ),
    ];
  }

  List<Widget> _displayDynamicWidgetList(
    ProductCategory category,
    FinancialProduct product,
    ColorScheme colorScheme,
  ) {
    return [
      if (category != ProductCategory.isaMp)
        textFrame(
          "가입 방법: ${(product.commonInfo.joinWay == null || product.commonInfo.joinWay!.isEmpty) ? "미제공" : product.commonInfo.joinWay!.join(",")}",
          colorScheme.onSecondary,
        ),
      if (category == ProductCategory.deposit ||
          category == ProductCategory.installment) ...[
        textFrame(
          "가입 제한: ${((product as DepositAndInstallmentSavings).joinDeny == null || product.joinDeny == "null") ? "미제공" : replace(product.joinDeny!)}",
          colorScheme.onSecondary,
        ),
        textFrame(
          "가입 대상: ${(product.joinMember == null || product.joinMember == "null") ? "미제공" : replace(product.joinMember!)}",
          colorScheme.onSecondary,
        ),
      ] else if (category == ProductCategory.credit) ...[
        textFrame(
          "CB 회사: ${((product as CreditLoan).cbName == null || product.cbName == "null") ? "미제공" : replace(product.cbName!)}",
          colorScheme.onSecondary,
        ),
        textFrame(
          "대출 종류 ${(product.productTypeName == null || product.productTypeName == "null") ? "미제공" : replace(product.productTypeName!)}",
          colorScheme.onSecondary,
        ),
      ] else if (category == ProductCategory.annuity) ...[
        textFrame(
          "연금 종류: ${((product as AnnuitySavings).pensionKindName == null || product.pensionKindName == "null") ? "미제공" : replace(product.pensionKindName!)}",
          colorScheme.onSecondary,
        ),
        textFrame(
          "상품 유형: ${(product.productTypeName == null || product.productTypeName == "null") ? "미제공" : replace(product.productTypeName!)}",
          colorScheme.onSecondary,
        ),
        textFrame(
          "판매사: ${(product.saleCompany == null || product.saleCompany == "null") ? "미제공" : replace(product.saleCompany!)}",
          colorScheme.onSecondary,
        ),
      ] else if (category == ProductCategory.isaMp) ...[
        textFrame(
          "업권: ${((product as IsaMpBenefitRate).businessDomain == null || product.businessDomain == "null") ? "미제공" : replace(product.businessDomain!)}",
          colorScheme.onSecondary,
        ),
        textFrame(
          "mp유형: ${(product.mpType == null || product.mpType == "null") ? "미제공" : replace(product.mpType!)}",
          colorScheme.onSecondary,
        ),
      ] else
        ...[],
      textFrame(
        "공시 제출일: ${(product.commonInfo.submittedDay == null) ? "미제공" : addSlash(product.commonInfo.submittedDay!)}",
        colorScheme.onSecondary,
      ),
      const SizedBox(height: 24.0),
      Text(
        switch (category) {
          ProductCategory.credit => "대출 금리 안내",
          ProductCategory.annuity => "상품 공시 현황",
          ProductCategory.isaMp => "수익률",
          _ => "상품 세부사항",
        },
        style: bodySbLg.copyWith(color: colorScheme.onPrimary),
      ),
      Divider(thickness: 1, color: colorScheme.onSecondary),
      const SizedBox(height: 14.0),
      if (category == ProductCategory.deposit ||
          category == ProductCategory.installment) ...[
        textFrame("금리", colorScheme.onSecondary),
        const SizedBox(height: 14.0),
        dataTableFrame(
          category,
          (category == ProductCategory.deposit)
              ? const ["금리 유형", "기간(개월)", "기본 금리", "최고 우대 금리"]
              : const ["금리 유형", "적금 유형", "기간(개월)", "금리", "최고 우대 금리"],
          (product as DepositAndInstallmentSavings).options,
          colorScheme,
        ),
        const SizedBox(height: 14.0),
        textFrame(
          "만기 후 이자율:\n${(product.interestAfterExpiration == null || product.interestAfterExpiration == "null") ? "미제공" : replace(product.interestAfterExpiration!)}",
          colorScheme.onSecondary,
        ),
        const SizedBox(height: 14.0),
        textFrame(
          "우대 조건:\n${(product.specialCondition == null || product.specialCondition == "null") ? "미제공" : replace(product.specialCondition!)}",
          colorScheme.onSecondary,
        ),
        const SizedBox(height: 14.0),
        textFrame(
          "기타 유의 사항:\n${(product.etc == null || product.etc == "null") ? "미제공" : replace(product.etc!)}",
          colorScheme.onSecondary,
        ),
      ] else if (category == ProductCategory.mortgage ||
          category == ProductCategory.rent) ...[
        textFrame("금리", colorScheme.onSecondary),
        const SizedBox(height: 14.0),
        dataTableFrame(
          category,
          (category == ProductCategory.mortgage)
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
          colorScheme,
        ),
        const SizedBox(height: 14.0),
        textFrame(
          "대출 부대 비용:\n${(product.extraExpense == null || product.extraExpense == "null") ? "미제공" : replace(product.extraExpense!)}",
          colorScheme.onSecondary,
        ),
        const SizedBox(height: 14.0),
        textFrame(
          "중도 상환 수수료:\n${(product.earlyRepayFee == null || product.earlyRepayFee == "null") ? "미제공" : replace(product.earlyRepayFee!)}",
          colorScheme.onSecondary,
        ),
        const SizedBox(height: 14.0),
        textFrame(
          "연체 이자율:\n${(product.delayRate == null || product.delayRate == "null") ? "미제공" : replace(product.delayRate!)}",
          colorScheme.onSecondary,
        ),
        const SizedBox(height: 14.0),
        textFrame(
          "대출 한도: ${(product.loanLimit == null || product.loanLimit == "null") ? "미제공" : replace(product.loanLimit!)}",
          colorScheme.onSecondary,
        ),
      ] else if (category == ProductCategory.credit)
        tableFrame(category, (product as CreditLoan).options, colorScheme)
      else if (category == ProductCategory.annuity) ...[
        textFrame(
          "유지건수/설정액 ${((product as AnnuitySavings).maintenanceCount == null || product.maintenanceCount == "null") ? "미제공" : replace(product.maintenanceCount!)}",
          colorScheme.onSecondary,
        ),
        textFrame(
          "평균 수익률: ${(product.averageProfit == null) ? "미제공" : product.averageProfit}",
          colorScheme.onSecondary,
        ),
        textFrame(
          "공시 이율: ${(product.declaredRate == null || product.declaredRate == "null") ? "미제공" : replace(product.declaredRate!)}",
          colorScheme.onSecondary,
        ),
        textFrame(
          "최저 보증 이율: ${(product.guaranteedRate == null || product.guaranteedRate == "null") ? "미제공" : replace(product.guaranteedRate!)}",
          colorScheme.onSecondary,
        ),
        textFrame(
          "전년도 수익률: ${(product.pyProfitRate == null) ? "미제공" : product.pyProfitRate}",
          colorScheme.onSecondary,
        ),
        textFrame(
          "전전년도 수익률: ${(product.ppyProfitRate == null) ? "미제공" : product.ppyProfitRate}",
          colorScheme.onSecondary,
        ),
        textFrame(
          "전전전년도 수익률: ${(product.pppyProfitRate == null) ? "미제공" : product.pppyProfitRate}",
          colorScheme.onSecondary,
        ),
      ] else
        tableFrame(
          category,
          (product as IsaMpBenefitRate).options,
          colorScheme,
        ),
    ];
  }

  String replace(String text) {
    return text.replaceAll(r'\\n', "\n");
  }

  String addSlash(String text) {
    return "${text.substring(0, 4)}/${text.substring(4, 6)}/${text.substring(6, 8)}";
  }
}
