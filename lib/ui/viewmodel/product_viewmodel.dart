import 'package:finbrain/data/converter.dart';
import 'package:finbrain/data/google_auth_service.dart';
import 'package:finbrain/data/model/entities/credit_loan.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/model/entities/isa_mp_benefit_rate.dart';
import 'package:finbrain/data/model/entities/mortgage_and_rent_loan.dart';
import 'package:finbrain/data/repository/product_repository.dart';
import 'package:finbrain/ui/viewmodel/current_page_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/sort_or_filter_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/filters_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/liked_product_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'product_viewmodel.g.dart';

final repository = ProductRepository();

@riverpod
class FetchProductViewmodel extends _$FetchProductViewmodel {
  @override
  Future<(int, List<FinancialProduct>)> build(
    ProductCategory ctg,
    String pageNo,
  ) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        throw Exception("[user] no user found");
      }
      final filters = ref.watch(savedFiltersProvider(ctg));
      Map<String, List<String>> selectedFilters = {};
      for (final entry in (filters.value ?? {}).entries) {
        selectedFilters[entry.key] = entry.value
            .where((e) => e.$2 == true)
            .map((e) => e.$1)
            .toList();
      }
      final topFinGrpNo =
          getFinGroupCode[selectedFilters["금융회사"]?.first ?? "020000"] ??
          "020000";
      if (selectedFilters["회사 선택"] != null &&
          selectedFilters["회사 선택"]!.isEmpty) {
        final List<String> companies = [];
        for (final filter in (filters.value ?? {})["회사 선택"]!) {
          companies.add(filter.$1);
        }
        selectedFilters["회사 선택"] = companies;
      }

      final baseYear = (selectedFilters["기준년도"]?.isNotEmpty ?? false)
          ? selectedFilters["기준년도"]!.first
          : DateTime.now().year.toString();
      final result = (ctg == ProductCategory.isaMp)
          ? await repository.fetchIsaMpProductsAndCount(
              user.uid,
              pageNo,
              "1000",
              baseYear,
            )
          : await repository.fetchFinlifeProductsAndPageNo(
              user.uid,
              ctg,
              topFinGrpNo,
              pageNo,
            );
      final maxPage = result.$1;
      final products = result.$2;
      final Set<String> finalSeenKeys = {};
      final List<FinancialProduct> distinctProducts = [];

      for (var prdt in products) {
        final company = prdt.commonInfo.companyName!.replaceAll(' ', '').trim();
        final product = prdt.commonInfo.productName!.replaceAll(' ', '').trim();
        final key = "${company}_${product}";

        if (finalSeenKeys.add(key)) {
          distinctProducts.add(prdt);
        }
      }
      
      final filtered = (ctg == ProductCategory.isaMp)
          ? distinctProducts
                .where(
                  (element) =>
                      (selectedFilters["업권"] ?? []).contains(
                        (element as IsaMpBenefitRate).businessDomain,
                      ) &&
                      (selectedFilters["MP 종류"] ?? []).contains(element.mpType),
                )
                .toList()
          : distinctProducts
                .where(
                  (element) =>
                      (selectedFilters["회사 선택"] ?? []).contains(
                        element.commonInfo.companyName,
                      ) &&
                      element.commonInfo.joinWay!.any(
                        (e) =>
                            (selectedFilters["가입 방법"] ??
                                    [
                                      "영업점",
                                      "인터넷",
                                      "스마트폰",
                                      "모집인",
                                      "전화(텔레뱅킹)",
                                      "기타",
                                    ])
                                .contains(e),
                      ),
                )
                .toList();

      return (maxPage, filtered);
    } catch (e) {
      debugPrint("[error] failed to financial products : $e");
      return (-1, <FinancialProduct>[]);
    }
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

    state = AsyncValue.data((currentState.$1, updated));

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
}

@riverpod
class ProductViewmodel extends _$ProductViewmodel {
  @override
  AsyncValue<(int, List<FinancialProduct>)> build(
    ProductCategory ctg,
    String pageNo,
  ) {
    final result = ref.watch(fetchProductViewmodelProvider(ctg, pageNo));
    final criteria = ref
        .watch(sortOrFilterTextViewModelProvider(ctg))
        .$1
        .toString();

    return result.when(
      data: (data) => sortByCriteria(criteria, ctg, data.$1, data.$2),
      error: (error, stackTrace) => AsyncValue.error(
        "[error] failed to fetch financial products",
        stackTrace,
      ),
      loading: () => const AsyncValue.loading(),
    );
  }

  AsyncValue<(int, List<FinancialProduct>)> sortByCriteria(
    String criteria,
    ProductCategory category,
    int maxPage, [
    List<FinancialProduct>? prdt,
  ]) {
    final products =
        prdt ?? ((state.value == null) ? [] : [...state.value!.$2]);

    final sorted = switch (category) {
      ProductCategory.deposit ||
      ProductCategory.installment => AsyncValue.data((
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
      )),
      ProductCategory.mortgage || ProductCategory.rent => AsyncValue.data((
        maxPage,
        products..sort(switch (criteria) {
          "최저 금리(낮은 순)" => (a, b) {
            if ((a as MortgageAndRentLoan).returnRates()[0] == null) {
              return 1;
            } else if ((b as MortgageAndRentLoan).returnRates()[0] == null) {
              return -1;
            } else {
              return a.returnRates()[0]!.compareTo(b.returnRates()[0]!);
            }
          },
          "최고 금리(낮은 순)" => (a, b) {
            if ((a as MortgageAndRentLoan).returnRates()[2] == null) {
              return 1;
            } else if ((b as MortgageAndRentLoan).returnRates()[2] == null) {
              return -1;
            } else {
              return a.returnRates()[2]!.compareTo(b.returnRates()[2]!);
            }
          },
          _ => (a, b) {
            if ((a as MortgageAndRentLoan).returnRates()[1] == null) {
              return 1;
            } else if ((b as MortgageAndRentLoan).returnRates()[1] == null) {
              return -1;
            } else {
              return a.returnRates()[1]!.compareTo(b.returnRates()[1]!);
            }
          },
        }),
      )),
      ProductCategory.credit => AsyncValue.data((
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
      )),
      _ => AsyncData((
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
      )),
    };
    state = sorted;
    return sorted;
  }

  void filterByKeyword(String keyword) {
    if (keyword.isNotEmpty) {
      final currentState = state.value ?? (0, <FinancialProduct>[]);
      state = AsyncValue.data((
        currentState.$1,
        currentState.$2
            .where((e) => e.commonInfo.productName!.contains(keyword))
            .toList(),
      ));
    } else {
      final page = ref.read(currentPageViewmodelProvider(ctg));
      final original = ref.read(fetchProductViewmodelProvider(ctg, "$page"));
      final maxPage = (original.value == null) ? 0 : original.value!.$1;
      final products = (original.value == null)
          ? <FinancialProduct>[]
          : original.value!.$2;
      final criteria = ref
          .read(sortOrFilterTextViewModelProvider(ctg))
          .$1
          .toString();
      state = sortByCriteria(criteria, ctg, maxPage, products);
    }
  }
}
