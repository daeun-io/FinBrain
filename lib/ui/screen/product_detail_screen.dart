import 'package:finbrain/data/model/entities/credit_loan.dart';
import 'package:finbrain/data/model/entities/credit_loan_option.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings_option.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/model/entities/isa_mp_benefit_rate.dart';
import 'package:finbrain/data/model/entities/isa_mp_benefit_rate_option.dart';
import 'package:finbrain/data/model/entities/mortgage_and_rent_loan.dart';
import 'package:finbrain/data/model/entities/mortgage_and_rent_loan_option.dart';
import 'package:finbrain/themes/text_style.dart';
import 'package:finbrain/ui/screen/ai_assist_screen.dart';
import 'package:finbrain/ui/viewmodel/current_page_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/liked_product_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/product_detail_screen_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/calculator_screen.dart';
import 'package:finbrain/ui/widget/ai_button.dart';
import 'package:finbrain/ui/widget/custom_appbar.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/showing_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_view/split_view.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  const ProductDetailScreen({
    super.key,
    required this.productCode,
    required this.productName,
    required this.category,
    required this.fromLikedScreen,
  });

  final String productCode;             // 상품 코드(product code)
  final String productName;             // 상품명(product name)
  final ProductCategory category;       // 상품 카테고리(product category)
  final bool fromLikedScreen;           // 관심 스크린에서 호출됐는지 여부(whether is called from liked screen)

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  bool isBtnClicked = false;

  // 공식 웹사이트로 이동하는 함수
  // Function to launch official website
  void launchPrdtUrl(
    WidgetRef ref,
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
    String companyName,
  ) {
    ref
        .read(productDetailScreenViewmodelProvider.notifier)
        .fetchAndOpenProductUrl(companyName, widget.productName)
        .then((isSuccess) {
          if (!isSuccess) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: colorScheme.scrim,
                duration: Duration(seconds: 3),
                content: Text(
                  "오류: 외부 url으로의 이동이 실패했습니다, 다시 시도해주세요",
                  style: textTheme.bodySmall!.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // 상품 리스트 불러오기
    // Fetch product list
    final page = ref.watch(currentPageViewmodelProvider(widget.category));
    final productList = ref.watch(
      fetchProductViewmodelProvider(widget.category, "$page"),
    );
    final likedList = ref.watch(fetchLikedViewmodelProvider);

    // 호출된 부모 스크린에 따라 상품 이름/코드로 데이터 찾기
    // Find data with product code or name in product list
    return ((widget.fromLikedScreen) ? likedList : productList).when(
      data: (data) {
        final product =
            ((widget.fromLikedScreen)
                    ? data as List<FinancialProduct>
                    : (data as (int, List<FinancialProduct>)).$2)
                .where(
                  (e) => (widget.category == ProductCategory.isaMp)
                      ? e.commonInfo.productName == widget.productName
                      : e.commonInfo.productCode == widget.productCode,
                )
                .firstOrNull;
        // 상품이 없을 경우 원래 화면으로 돌아가기
        // Back to main screen when no product found
        if (product == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          });
          return Scaffold(
            backgroundColor: colorScheme.primary,
            body: SizedBox.shrink(),
          );
        }

        // 타블렛일 때 버튼을 누르면 AI 어시스트 스크린을 스플릿 뷰로, 핸드폰이면 네비게이션으로 이동
        // if tablet, show assist screen through split view, else navigate
        return SplitView(
          viewMode: SplitViewMode.Horizontal,
          controller: SplitViewController(
            weights: (isBtnClicked) ? const [0.5, 0.5] : const [1.0, 0.0],
          ),
          indicator: const SplitIndicator(viewMode: SplitViewMode.Horizontal),
          activeIndicator: SplitIndicator(
            viewMode: SplitViewMode.Horizontal,
            color: colorScheme.onTertiary,
          ),
          children: [
            detailScreen(product, colorScheme, textTheme, page),
            if (isBtnClicked)
              AiAssistScreen(
                tag: (widget.category == ProductCategory.isaMp)
                    ? widget.productName
                    : widget.productCode,
                category: product.commonInfo.category,
                name: widget.productName,
              ),
          ],
        );
      },
      error: (err, stack) => Scaffold(
        backgroundColor: colorScheme.primary,
        body: const ShowingErrorWidget(),
      ),
      loading: () => Scaffold(
        backgroundColor: colorScheme.primary,
        body: const CustomProgressIndicator(),
      ),
    );
  }

  // 실제 상세 화면 스크린
  // Actual product detail screen
  Widget detailScreen(
    FinancialProduct product,
    ColorScheme colorScheme,
    TextTheme textTheme,
    int page,
  ) {
    return Scaffold(
      backgroundColor: colorScheme.primary,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          screen: "detail",
          title: widget.productName.replaceAll(r'\\n', ""),
          product: product,
          page: page,
        ),
      ),
      body: SafeArea(
        child: SizedBox.expand(
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
                    // 상세 정보(detailed information)
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._displayDefaultWidgetList(
                          product,
                          colorScheme,
                          textTheme,
                        ),
                        ..._displayDynamicWidgetList(
                          product.commonInfo.category,
                          product,
                          colorScheme,
                          textTheme,
                        ),
                        SizedBox(height: 160.0),
                      ],
                    ),
                  ),
                ),
              ),
              // AI 도우미 버튼(AI Button)
              Positioned(
                right: 20,
                bottom: 100,
                child: AiButton(
                  tag: (widget.category == ProductCategory.isaMp)
                      ? product.commonInfo.productName!
                      : product.commonInfo.productCode!,
                  name: product.commonInfo.productName!,
                  category: product.commonInfo.category,
                  isBtnClicked: () {
                    final width = MediaQuery.of(context).size.width;
                    if (width >= 600) {
                      setState(() {
                        isBtnClicked = !isBtnClicked;
                      });
                    }
                  },
                ),
              ),
              // 네비게이션 버튼(계산기, 공식 사이트)
              // Navigation Button(calculator, official site)
              if (product.commonInfo.category == ProductCategory.isaMp)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: navToWebsite(product),
                )
              else
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: navToCalculator(product)),
                      Expanded(child: navToWebsite(product)),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navToCalculator(FinancialProduct product) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) {
              // 카테고리에 따라 옵션 추출
              // Extract options based on category
              final options = switch (product.commonInfo.category) {
                ProductCategory.deposit =>
                  (product as DepositAndInstallmentSavings).options,
                ProductCategory.installment =>
                  (product as DepositAndInstallmentSavings).options,
                ProductCategory.credit => (product as CreditLoan).options,
                _ => (product as MortgageAndRentLoan).options,
              };
              return CalculatorScreen(
                category: product.commonInfo.category,
                mapOptions: ref
                    .read(productDetailScreenViewmodelProvider.notifier)
                    .mapProductOptions(product.commonInfo.category, options),
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
          border: Border.all(color: colorScheme.outline, width: 1.0),
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
              style: textTheme.titleLarge!.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget navToWebsite(FinancialProduct product) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => launchPrdtUrl(
        ref,
        context,
        colorScheme,
        textTheme,
        product.commonInfo.companyName ?? "",
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          border: Border.all(color: colorScheme.outline, width: 1.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.ads_click, color: colorScheme.onSecondary, size: 24.0),
            const SizedBox(width: 4.0),
            Text(
              "공식 홈페이지로",
              style: textTheme.titleLarge!.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _displayDefaultWidgetList(
    FinancialProduct product,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return [
      Text("상품 안내", style: bodySbLg.copyWith(color: colorScheme.onPrimary)),
      Divider(thickness: 1, color: colorScheme.onSecondary),
      textFrame("금융 상품명: ${replace(product.commonInfo.productName!)}"),
      textFrame("금융회사: ${replace(product.commonInfo.companyName ?? "미제공")}"),
    ];
  }

  List<Widget> _displayDynamicWidgetList(
    ProductCategory category,
    FinancialProduct product,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return [
      if (category != ProductCategory.isaMp)
        textFrame(
          "가입 방법: ${(product.commonInfo.joinWay == null || product.commonInfo.joinWay!.isEmpty) ? "미제공" : product.commonInfo.joinWay!.join(",")}",
        ),
      if (category == ProductCategory.deposit ||
          category == ProductCategory.installment) ...[
        textFrame(
          "가입 제한: ${((product as DepositAndInstallmentSavings).joinDeny == null || product.joinDeny == "null") ? "미제공" : replace(product.joinDeny!)}",
        ),
        textFrame(
          "가입 대상: ${(product.joinMember == null || product.joinMember == "null") ? "미제공" : replace(product.joinMember!)}",
        ),
      ] else if (category == ProductCategory.isaMp) ...[
        textFrame(
          "업권: ${((product as IsaMpBenefitRate).businessDomain == null || product.businessDomain == "null") ? "미제공" : replace(product.businessDomain!)}",
        ),
        textFrame(
          "mp유형: ${(product.mpType == null || product.mpType == "null") ? "미제공" : replace(product.mpType!)}",
        ),
      ] else
        ...[],
      textFrame(
        "공시 제출일: ${(product.commonInfo.submittedDay == null) ? "미제공" : addSlash(product.commonInfo.submittedDay!)}",
      ),
      const SizedBox(height: 24.0),
      Text(switch (category) {
        ProductCategory.credit => "대출 금리 안내",
        ProductCategory.isaMp => "수익률",
        _ => "상품 세부사항",
      }, style: bodySbLg.copyWith(color: colorScheme.onPrimary)),
      Divider(thickness: 1, color: colorScheme.onSecondary),
      const SizedBox(height: 14.0),
      if (category == ProductCategory.deposit ||
          category == ProductCategory.installment) ...[
        textFrame("금리"),
        const SizedBox(height: 14.0),
        dataTableFrame(
          category,
          (category == ProductCategory.deposit)
              ? const ["금리 유형", "기간(개월)", "기본 금리", "최고 우대 금리"]
              : const ["금리 유형", "적금 유형", "기간(개월)", "금리", "최고 우대 금리"],
          (product as DepositAndInstallmentSavings).options,
        ),
        const SizedBox(height: 14.0),
        textFrame(
          "만기 후 이자율:\n${(product.interestAfterExpiration == null || product.interestAfterExpiration == "null") ? "미제공" : replace(product.interestAfterExpiration!)}",
        ),
        const SizedBox(height: 14.0),
        textFrame(
          "우대 조건:\n${(product.specialCondition == null || product.specialCondition == "null") ? "미제공" : replace(product.specialCondition!)}",
        ),
        const SizedBox(height: 14.0),
        textFrame(
          "기타 유의 사항:\n${(product.etc == null || product.etc == "null") ? "미제공" : replace(product.etc!)}",
        ),
      ] else if (category == ProductCategory.mortgage ||
          category == ProductCategory.rent) ...[
        textFrame("금리"),
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
          (product as MortgageAndRentLoan).options,
        ),
        const SizedBox(height: 14.0),
        textFrame(
          "대출 부대 비용:\n${(product.extraExpense == null || product.extraExpense == "null") ? "미제공" : replace(product.extraExpense!)}",
        ),
        const SizedBox(height: 14.0),
        textFrame(
          "중도 상환 수수료:\n${(product.earlyRepayFee == null || product.earlyRepayFee == "null") ? "미제공" : replace(product.earlyRepayFee!)}",
        ),
        const SizedBox(height: 14.0),
        textFrame(
          "연체 이자율:\n${(product.delayRate == null || product.delayRate == "null") ? "미제공" : replace(product.delayRate!)}",
        ),
        const SizedBox(height: 14.0),
        textFrame(
          "대출 한도: ${(product.loanLimit == null || product.loanLimit == "null") ? "미제공" : replace(product.loanLimit!)}",
        ),
      ] else if (category == ProductCategory.credit)
        tableFrame(
          category,
          (product as CreditLoan).options,
          colorScheme,
          textTheme,
        )
      else
        tableFrame(
          category,
          (product as IsaMpBenefitRate).options,
          colorScheme,
          textTheme,
        ),
    ];
  }

  // 개인신용대출 및 ISA 상품 표
  // Credit loan interest and ISA products' profit rate
  Widget tableFrame(
    ProductCategory category,
    List<dynamic> options,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    if (category == ProductCategory.credit) {
      return Column(
        children: [
          for (final option in options as List<CreditLoanOption>)
            if (option.creditLendRateTypeName != null) ...[
              textFrame(option.creditLendRateTypeName!),
              const SizedBox(height: 8.0),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(color: colorScheme.outline),
                children: [
                  ("신용 등급", "대출 금리"),
                  (
                    "900점 초과",
                    (option.gradeOver900 == null)
                        ? "미제공"
                        : option.gradeOver900.toString(),
                  ),
                  (
                    "801~900점",
                    (option.grade801900 == null)
                        ? "미제공"
                        : option.grade801900.toString(),
                  ),
                  (
                    "701~800점",
                    (option.grade701800 == null)
                        ? "미제공"
                        : option.grade701800.toString(),
                  ),
                  (
                    "601~700점",
                    (option.grade601700 == null)
                        ? "미제공"
                        : option.grade601700.toString(),
                  ),
                  (
                    "501~600점",
                    (option.grade501600 == null)
                        ? "미제공"
                        : option.grade501600.toString(),
                  ),
                  (
                    "401~500점",
                    (option.grade401500 == null)
                        ? "미제공"
                        : option.grade401500.toString(),
                  ),
                  (
                    "301~400점",
                    (option.grade301400 == null)
                        ? "미제공"
                        : option.grade301400.toString(),
                  ),
                  (
                    "300점 이하",
                    (option.gradeUnder300 == null)
                        ? "미제공"
                        : option.gradeUnder300.toString(),
                  ),
                  (
                    "평균 금리",
                    (option.averageGrade == null)
                        ? "미제공"
                        : option.averageGrade.toString(),
                  ),
                ].map((e) => tableRow(e)).toList(),
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
            children: [tableCellFrame("기간"), tableCellFrame("수익률")],
          ),
          for (final option in options as List<IsaMpBenefitRateOption>) ...[
            if (option.term != null && option.benefitRate != null)
              TableRow(
                children: [
                  tableCellFrame(option.term!),
                  tableCellFrame(
                    (option.benefitRate == null)
                        ? "미제공"
                        : option.benefitRate.toString(),
                  ),
                ],
              ),
          ],
        ],
      );
    }
  }

  TableRow tableRow((String, String) values) {
    final colorScheme = Theme.of(context).colorScheme;

    return TableRow(
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        border: BoxBorder.all(color: colorScheme.outline),
      ),
      children: [tableCellFrame(values.$1), tableCellFrame(values.$2)],
    );
  }

  Widget tableCellFrame(String text, [TextStyle? textStyle]) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(child: textFrame(text, textStyle)),
      ),
    );
  }

  Widget textFrame(String text, [TextStyle? textStyle]) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Text(
      text,
      style:
          textStyle ??
          textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary),
    );
  }
  // 예적금 및 주택담보대출, 전세자금대출 금리 표
  // Savings, mortgage and rent loan interest table
  Widget dataTableFrame(
    ProductCategory category,
    List<String> columns,
    List<dynamic> options,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

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
                    children: [dataTableCellText(column)],
                  ),
                ),
              ),
          ],
          rows: [
            if (category == ProductCategory.deposit)
              for (final option
                  in options as List<DepositAndInstallmentSavingsOption>)
                dataTableRow([
                  option.intRateTypeName ?? "미제공",
                  (option.saveTerm == null)
                      ? "미제공"
                      : option.saveTerm.toString(),
                  (option.intRate == null) ? "미제공" : option.intRate.toString(),
                  (option.maxIntRate == null)
                      ? "미제공"
                      : option.maxIntRate.toString(),
                ]),
            if (category == ProductCategory.installment)
              for (final option
                  in options as List<DepositAndInstallmentSavingsOption>)
                dataTableRow([
                  option.intRateTypeName ?? "미제공",
                  option.reserveTypeName ?? "미제공",
                  (option.saveTerm == null)
                      ? "미제공"
                      : option.saveTerm.toString(),
                  (option.intRate == null) ? "미제공" : option.intRate.toString(),
                  (option.maxIntRate == null)
                      ? "미제공"
                      : option.maxIntRate.toString(),
                ]),
            if (category == ProductCategory.mortgage)
              for (final option in options as List<MortgageAndRentLoanOption>)
                dataTableRow([
                  option.loanTypeName ?? "미제공",
                  option.repayTypeName ?? "미제공",
                  option.lendRateTypeName ?? "미제공",
                  (option.lendRateMin == null)
                      ? "미제공"
                      : option.lendRateMin.toString(),
                  (option.lendRateMax == null)
                      ? "미제공"
                      : option.lendRateMax.toString(),
                  (option.lendRateAvg == null)
                      ? "미제공"
                      : option.lendRateAvg.toString(),
                ]),
            if (category == ProductCategory.rent)
              for (final option in options as List<MortgageAndRentLoanOption>)
                dataTableRow([
                  option.repayTypeName ?? "미제공",
                  option.lendRateTypeName ?? "미제공",
                  (option.lendRateMin == null)
                      ? "미제공"
                      : option.lendRateMin.toString(),
                  (option.lendRateMax == null)
                      ? "미제공"
                      : option.lendRateMax.toString(),
                  (option.lendRateAvg == null)
                      ? "미제공"
                      : option.lendRateAvg.toString(),
                ]),
          ],
        ),
      ),
    );
  }

  DataRow dataTableRow(List<String> values) {
    return DataRow(
      cells: values.map((e) => DataCell(dataTableCellText(e))).toList(),
    );
  }

  Widget dataTableCellText(String text, [TextStyle? textStyle]) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style:
            textStyle ??
            textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary),
      ),
    );
  }

  // 문자열 변환기: \\n -> \n
  // Formatter: replace \\n -> \n
  String replace(String text) {
    return text.replaceAll(r'\\n', "\n");
  }

  // 날짜 문자열 변환기: YYYY/MM/DD
  // Formatter: add splash to date(YYYY/MM/DD)
  String addSlash(String text) {
    return "${text.substring(0, 4)}/${text.substring(4, 6)}/${text.substring(6, 8)}";
  }
}
