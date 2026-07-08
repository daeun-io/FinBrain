import 'package:finbrain/data/converter.dart';
import 'package:finbrain/data/google_auth_service.dart';
import 'package:finbrain/data/model/entities/annuity_savings.dart';
import 'package:finbrain/data/model/entities/credit_loan.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/model/entities/isa_mp_benefit_rate.dart';
import 'package:finbrain/data/model/entities/mortage_and_rent_loan.dart';
import 'package:finbrain/data/repository/product_repository.dart';
import 'package:finbrain/ui/viewmodel/sort_or_filter_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/filters_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/liked_product_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:flutter/material.dart';
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
    String pageNo, [
    Map<String, List<(String, bool)>>? snapshot,
  ]) async {
    final user = GoogleAuthService.getCurrentUser();
    if (user == null) {
      debugPrint("No user is currently signed in.");
      state = AsyncData((0, <FinancialProduct>[]));
      return;
    }

    if (ctg == ProductCategory.isaMp &&
        ctg == ProductCategory.isaJoin &&
        ctg == ProductCategory.isaManagement &&
        ctg == ProductCategory.liked) {
      state = AsyncData((0, <FinancialProduct>[]));
    }

    final filters =
        snapshot ??
        (await ref.read(filtersViewmodelProvider(ctg).future) ?? {});

    Map<String, List<String>> selectedFilters = {};
    for (final entry in filters.entries) {
      selectedFilters[entry.key] = entry.value
          .where((e) => e.$2 == true)
          .map((e) => e.$1)
          .toList();
    }
    final topFinGrpNo =
        getFinGroupCode[selectedFilters["금융회사"]?.first ??
            ((ctg == ProductCategory.annuity) ? "050000" : "020000")] ??
        ((ctg == ProductCategory.annuity) ? "050000" : "020000");
    print("topFinGrpNo: $topFinGrpNo");
    if (selectedFilters["회사 선택"] != null && selectedFilters["회사 선택"]!.isEmpty) {
      final List<String> companies = [];
      for (final filter in filters["회사 선택"]!) {
        companies.add(filter.$1);
      }
      selectedFilters["회사 선택"] = companies;
    }

    final criteria = ref
        .read(sortOrFilterTextViewModelProvider(ctg))
        .$1
        .toString();

    final result = await repository.fetchFinlifeProductsAndPageNo(
      user.uid,
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
    sortByCriteria(criteria, ctg, maxPage, filtered);
  }

  void fetchIsaMpProducts(
    String pageNo, [
    Map<String, List<(String, bool)>>? snapshot,
  ]) async {
    final user = GoogleAuthService.getCurrentUser();
    if (user == null) {
      debugPrint("No user is currently signed in.");
      state = AsyncData((0, <FinancialProduct>[]));
      return;
    }

    final filters =
        snapshot ??
        (await ref.read(
              filtersViewmodelProvider(ProductCategory.isaMp).future,
            ) ??
            {});
    Map<String, List<String>> selectedFilters = {};
    for (final entry in filters.entries) {
      selectedFilters[entry.key] = entry.value
          .where((e) => e.$2 == true)
          .map((e) => e.$1)
          .toList();
    }

    final baseYear = (selectedFilters["기준년도"]?.isNotEmpty ?? false)
        ? selectedFilters["기준년도"]!.first
        : DateTime.now().year.toString();

    final result = await repository.fetchIsaMpProductsAndCount(
      user.uid,
      pageNo,
      "1000",
      baseYear,
    );

    final totalCount = result.$1;
    final products = result.$2;

    final filtered = products.where((element) {
      return (selectedFilters["업권"] ?? []).contains(
            (element as IsaMpBenefitRate).businessDomain,
          ) &&
          (selectedFilters["MP 종류"] ?? []).contains(element.mpType);
    }).toList();

    final criteria = ref
        .read(sortOrFilterTextViewModelProvider(ProductCategory.isaMp))
        .$1
        .toString();

    sortByCriteria(criteria, ProductCategory.isaMp, totalCount, filtered);
  }

  void toggleLiked(FinancialProduct product) {
    final currentState = state.value ?? (0, <FinancialProduct>[]);
    final isLiked = product.commonInfo.isLiked;
    final updated = currentState.$2.map((e) {
      if (e.commonInfo.productName == product.commonInfo.productName) {
        return e.copyWith(!isLiked);
      } else {
        return e;
      }
    }).toList();
    state = AsyncData((currentState.$1, updated));

    if (isLiked == true) {
      ref
          .read(likedProductViewmodelProvider.notifier)
          .deleteInLikedList(product);
    } else {
      ref
          .read(likedProductViewmodelProvider.notifier)
          .addInLikedList(product.copyWith(!isLiked));
    }
  }

  void sortByCriteria(
    String criteria,
    ProductCategory category,
    int maxPage, [
    List<FinancialProduct>? prdt,
  ]) {
    final products =
        prdt ?? ((state.value == null) ? [] : [...state.value!.$2]);

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
      case ProductCategory.mortgage:
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
