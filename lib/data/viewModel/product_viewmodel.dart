import 'package:finbrain/data/models/entities/annuity_savings.dart';
import 'package:finbrain/data/models/entities/credit_loan.dart';
import 'package:finbrain/data/models/entities/deposit_and_installment_savings.dart';
import 'package:finbrain/data/models/entities/financial_product.dart';
import 'package:finbrain/data/models/entities/isa_mp_benefit_rate.dart';
import 'package:finbrain/data/models/entities/mortage_and_rent_loan.dart';
import 'package:finbrain/data/repository/product_repository.dart';
import 'package:finbrain/data/viewModel/filters_viewmodel.dart';
import 'package:finbrain/data/viewModel/sort_or_filter_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'product_viewmodel.g.dart';

final repository = ProductRepository();

@riverpod
class ProductViewmodel extends _$ProductViewmodel {
  @override
  Future<(int, List<FinancialProduct>)> build() async {
    return (0, <FinancialProduct>[]);
  }

  void fetchFinlifeProducts(
    ProductCategory ctg,
    String topFinGrpNo,
    String pageNo,
  ) async {
    if (ctg == ProductCategory.isa) {
      state = AsyncData((0, <FinancialProduct>[]));
    }

    final filterCtg = switch (ctg) {
      ProductCategory.annuity => FilterTextCategory.annuity,
      ProductCategory.deposit => FilterTextCategory.savings,
      ProductCategory.installment => FilterTextCategory.savings,
      _ => FilterTextCategory.loan,
    };

    final filters = await ref.read(filtersViewmodelProvider(filterCtg).future);
    Map<String, List<String>> selectedFilters = {};
    for (final entry in filters.entries) {
      selectedFilters[entry.key] = entry.value
          .where((e) => e.$2 == true)
          .map((e) => e.$1)
          .toList();
    }
    if (selectedFilters["회사 선택"] != null && selectedFilters["회사 선택"]!.isEmpty) {
      final List<String> companies = [];
      for (final filter in filters["회사 선택"]!) {
        companies.add(filter.$1);
      }
      selectedFilters["회사 선택"] = companies;
    }

    final criteria = ref
        .read(sortOrFilterTextViewModelProvider(filterCtg))
        .$1
        .toString();

    final result = await repository.fetchFinlifeProductsAndPageNo(
      ctg,
      topFinGrpNo,
      pageNo,
    );
    final maxPage = result.$1;
    final products = result.$2;

    final filtered = products.where((element) {
      return (selectedFilters["회사 선택"] ?? []).contains(
            element.commonInfo.companyName,
          ) &&
          element.commonInfo.joinWay!.any(
            (e) =>
                (selectedFilters["가입 방법"] ??
                        ["영업점", "인터넷", "스마트폰", "모집인", "전화(텔레뱅킹)", "기타"])
                    .contains(e),
          );
    }).toList();

    sortByCriteria(criteria, ctg, maxPage, products);
  }

  // todo: implement sort logic
  void fetchIsaMpProducts(
    String pageNo,
    String numOfRows,
    String baseYear,
    String domain,
    String mpType,
    String cmpy,
  ) async {
    final result = await repository.fetchIsaMpProductsAndCount(
      pageNo,
      numOfRows,
      baseYear,
      domain,
      mpType,
      cmpy,
    );
    state = AsyncData(result);
  }

  // todo: change later(insert a product in db)
  void toggleLiked(String productName) {
    final currentState = state.valueOrNull ?? (0, <FinancialProduct>[]);
    final products = currentState.$2;
    final updated = products.map((e) {
      if (e.commonInfo.productName == productName) {
        return e.copyWith(!e.commonInfo.isLiked);
      } else {
        return e;
      }
    }).toList();

    state = AsyncData((currentState.$1, updated));
    // todo: later updated at server
  }

  void sortByCriteria(
    String criteria,
    ProductCategory category,
    int maxPage, [
    List<FinancialProduct>? prdt,
  ]) {
    final products = prdt ?? ((state.value == null) ? [] : state.value!.$2);

    switch (category) {
      case ProductCategory.deposit:
      case ProductCategory.installment:
        state = AsyncData((
          maxPage,
          products..sort(
            (criteria == "최고 금리(높은 순)")
                ? (a, b) =>
                      ((b as DepositAndInstallmentSavings)
                              .returnHighestRateValue()
                              .$1)
                          .compareTo(
                            ((a as DepositAndInstallmentSavings)
                                .returnHighestRateValue()
                                .$1),
                          )
                : (a, b) =>
                      ((b as DepositAndInstallmentSavings)
                              .returnHighestRateValue()
                              .$2)
                          .compareTo(
                            ((a as DepositAndInstallmentSavings)
                                .returnHighestRateValue()
                                .$2),
                          ),
          ),
        ));
        break;
      case ProductCategory.annuity:
        state = AsyncData((
          maxPage,
          products..sort(switch (criteria) {
            "평균 수익률(높은 순)" =>
              (a, b) => (b as AnnuitySavings).returnProfits()[0].compareTo(
                (a as AnnuitySavings).returnProfits()[0],
              ),
            "전년도 수익률(높은 순)" =>
              (a, b) => (b as AnnuitySavings).returnProfits()[1].compareTo(
                (a as AnnuitySavings).returnProfits()[1],
              ),
            "전전년도 수익률(높은 순)" =>
              (a, b) => (b as AnnuitySavings).returnProfits()[2].compareTo(
                (a as AnnuitySavings).returnProfits()[2],
              ),
            _ => (a, b) => (b as AnnuitySavings).returnProfits()[3].compareTo(
              (a as AnnuitySavings).returnProfits()[3],
            ),
          }),
        ));
        break;
      case ProductCategory.mortage:
      case ProductCategory.rent:
        state = AsyncData((
          maxPage,
          products..sort(switch (criteria) {
            "최저 금리(낮은 순)" =>
              (a, b) => (a as MortageAndRentLoan).returnRates()[0].compareTo(
                (b as MortageAndRentLoan).returnRates()[0],
              ),
            "최고 금리(낮은 순)" =>
              (a, b) => (a as MortageAndRentLoan).returnRates()[2].compareTo(
                (b as MortageAndRentLoan).returnRates()[2],
              ),
            _ => (a, b) => (a as MortageAndRentLoan).returnRates()[1].compareTo(
              (b as MortageAndRentLoan).returnRates()[1],
            ),
          }),
        ));
      case ProductCategory.credit:
        state = AsyncData((
          maxPage,
          products..sort(switch (criteria) {
            "최저 금리(낮은 순)" =>
              (a, b) => (a as CreditLoan).returnRates()[0].compareTo(
                (b as CreditLoan).returnRates()[0],
              ),
            "최고 금리(낮은 순)" =>
              (a, b) => (a as CreditLoan).returnRates()[2].compareTo(
                (b as CreditLoan).returnRates()[2],
              ),
            _ => (a, b) => (a as CreditLoan).returnRates()[1].compareTo(
              (b as CreditLoan).returnRates()[1],
            ),
          }),
        ));
      default:
        state = AsyncData((
          maxPage,
          products..sort(switch (criteria) {
            "평균 수익률(높은 순)" =>
              (a, b) => (b as IsaMpBenefitRate)
                  .returnAvgMedProfits()
                  .$1
                  .compareTo((a as IsaMpBenefitRate).returnAvgMedProfits().$1),
            _ =>
              (a, b) => (b as IsaMpBenefitRate)
                  .returnAvgMedProfits()
                  .$2
                  .compareTo((a as IsaMpBenefitRate).returnAvgMedProfits().$2),
          }),
        ));
    }
  }

  void filterByKeyword(String keyword) {
    if (keyword.isNotEmpty) {
      final currentState = state.value ?? (0, <FinancialProduct>[]);
      state = AsyncData((
        currentState.$1,
        currentState.$2
            .where((e) => e.commonInfo.productName!.contains(keyword))
            .toList(),
      ));
    }
  }
}

// todo: change later(load db)
@riverpod
class LikedProductViewmodel extends _$LikedProductViewmodel {
  @override
  Future<List<FinancialProduct>> build() async {
    final products = List.generate(
      3,
      (index) => IsaMpBenefitRate(
        category: ProductCategory.isa,
        companyName: "cmpy_nm",
        mpName: "mp_nm",
        releaseDate: "20260622",
        isLiked: false,
        baseDate: "20260622",
        businessDomain: "bzds",
        mpType: "mp_type",
        options: [],
      ),
    );
    final filters = ref.watch(
      sortOrFilterTextViewModelProvider(FilterTextCategory.liked),
    );
    final categories = ((filters.$1 as List<String>).first == "모든 상품")
        ? [
            ProductCategory.deposit,
            ProductCategory.installment,
            ProductCategory.isa,
            ProductCategory.mortage,
            ProductCategory.rent,
            ProductCategory.credit,
            ProductCategory.annuity,
          ]
        : [
            for (final item in (filters.$1 as List<String>))
              if (item == "정기예금")
                ProductCategory.deposit
              else if (item == "적금")
                ProductCategory.installment
              else if (item == "ISA")
                ProductCategory.isa
              else if (item == "주택담보대출")
                ProductCategory.mortage
              else if (item == "전세자금대출")
                ProductCategory.rent
              else if (item == "개인신용대출")
                ProductCategory.credit
              else
                ProductCategory.annuity,
          ];

    return (products)
        .where(
          (e) =>
              e.commonInfo.isLiked == true &&
              categories.contains(e.commonInfo.category),
        )
        .toList();
  }

  void filterByKeyword(String keyword) {
    if (keyword.isNotEmpty) {
      state = AsyncData(
        (state.value ?? [])
            .where((e) => e.commonInfo.productName!.contains(keyword))
            .toList(),
      );
    }
  }
}
