import 'dart:async';
import 'package:finbrain/data/google_auth_service.dart';
import 'package:finbrain/data/model/entities/credit_loan.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/model/entities/isa_mp_benefit_rate.dart';
import 'package:finbrain/data/model/entities/mortgage_and_rent_loan.dart';
import 'package:finbrain/data/repository/product_repository.dart';
import 'package:finbrain/ui/viewmodel/current_page_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/selected_parameter_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/sort_or_filter_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/filters_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/liked_product_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'product_viewmodel.g.dart';

// 금융 상품 레포지토리
// Financial product repository
final repository = ProductRepository();

// 지정한 카테고리에 해당하는 상품 불러오는 뷰모델
// Fetching product based on given category viewmodel
@riverpod
class FetchProductViewmodel extends _$FetchProductViewmodel {
  @override
  Future<(int, List<FinancialProduct>)> build(
    ProductCategory ctg,
    int pageNo,
  ) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        throw Exception("[user] no user found");
      }

      final topFinGrpNo =
          ref.read(selectedTopFinGrpNoViewmodelProvider)[ctg] ?? "020000";
      final baseYear =
          ref.read(selectedBaseYearViewmodelProvider)[ctg] ??
          DateTime.now().year;

      return (ctg == ProductCategory.isaMp)
          ? await repository.fetchIsaMpProductsAndCount(
              user.uid,
              pageNo.toString(),
              "100",
              baseYear.toString(),
            )
          : await repository.fetchFinlifeProductsAndPageNo(
              user.uid,
              ctg,
              topFinGrpNo,
              pageNo.toString(),
            );
    } catch (e) {
      throw Exception("[error] failed to financial products : $e");
    }
  }

  // 관심 표시/미표시 하기
  // Toggle liked/unliked
  void toggleLiked(FinancialProduct product) {
    state.whenData((data) {
      // 현재 관심 상태 가져오기
      // Fetch current liked status of product
      final isLiked = product.commonInfo.isLiked;
      // 전체 리스트 업데이트하기
      // Update current list
      final updated = data.$2
          .map((e) {
            if ((product.commonInfo.category == ProductCategory.isaMp)
                ? e.commonInfo.productName == product.commonInfo.productName
                : e.commonInfo.productCode == product.commonInfo.productCode) {
              return e.copyWith(!isLiked);
            } else {
              return e;
            }
          })
          .whereType<FinancialProduct>()
          .toList();
      state = AsyncValue.data((data.$1, updated));

      // 관심 상품 서버에 반영하기
      // Apply new liked product list in server
      if (isLiked == true) {
        ref
            .read(likedProductViewmodelProvider.notifier)
            .deleteInLikedList(product);
      } else {
        ref
            .read(likedProductViewmodelProvider.notifier)
            .addInLikedList(product.copyWith(!isLiked));
      }
    });
  }
}

// 화면에 금융 상품 보이는 뷰모델
// Displaying financial products in screen
@riverpod
class ProductViewmodel extends _$ProductViewmodel {
  @override
  Future<(int, List<FinancialProduct>)> build(ProductCategory ctg) async {
    // 데이터, 필터, 기준 관찰하기
    // Watch data, filter and sorting criteria
    final cPage = ref.watch(currentPageViewmodelProvider(ctg));
    final criteria = ref.watch(sortOrFilterTextViewModelProvider(ctg));
    final filters = ref.watch(savedFiltersProvider(ctg));
    final result = await ref.read(
      fetchProductViewmodelProvider(ctg, cPage).future,
    );

    if (filters.value != null) {
      // 선택된 필터 추출
      // Extract selected filter value
      Map<String, List<String>> selectedFilters = {};
      for (final entry in filters.value!.entries) {
        selectedFilters[entry.key] = entry.value
            .where((e) => e.$2 == true)
            .map((e) => e.$1)
            .toList();
      }

      if (selectedFilters["회사 선택"] != null &&
          selectedFilters["회사 선택"]!.isEmpty) {
        final List<String> companies = [];
        for (final filter in filters.value!["회사 선택"]!) {
          companies.add(filter.$1);
        }
        selectedFilters["회사 선택"] = companies;
      }

      final maxPage = result.$1;
      final products = result.$2;

      // 회사명과 상품명이 중복되는 데이터 제거하기
      // Delete duplicated data where company and product name is same
      final Set<String> finalSeenKeys = {};
      final List<FinancialProduct> distinctProducts = [];

      for (var prdt in products) {
        final company = prdt.commonInfo.companyName!.replaceAll(' ', '').trim();
        final product = prdt.commonInfo.productName!.replaceAll(' ', '').trim();
        final key = "${company}_$product";

        if (finalSeenKeys.add(key)) {
          distinctProducts.add(prdt);
        }
      }

      // 필터 적용하기
      // Apply filter to data
      final selectedCtg = (selectedFilters["업권"] ?? []).toSet();
      final selectedMP = (selectedFilters["MP 종류"] ?? []).toSet();
      final selectedCmp = (selectedFilters["회사 선택"] ?? []).toSet();
      final selectedJoinWay =
          (selectedFilters["가입 방법"] ??
                  ["영업점", "인터넷", "스마트폰", "모집인", "전화(텔레뱅킹)", "기타"])
              .toSet();

      final filtered = (ctg == ProductCategory.isaMp)
          ? distinctProducts
                .where(
                  (element) =>
                      selectedCtg.contains(
                        (element as IsaMpBenefitRate).businessDomain,
                      ) &&
                      selectedMP.contains(element.mpType),
                )
                .toList()
          : distinctProducts
                .where(
                  (element) =>
                      selectedCmp.contains(element.commonInfo.companyName) &&
                      element.commonInfo.joinWay!.any(
                        (e) => selectedJoinWay.contains(e),
                      ),
                )
                .toList();

      // 데이터 정렬하기
      // Sort financial products
      final sorted = sortByCriteria(criteria.$1.toString(), ctg, filtered);
      return (maxPage, sorted);
    } else {
      return (-1, <FinancialProduct>[]);
    }
  }

  // 데이터 정렬하기
  // Sort data by criteria
  List<FinancialProduct> sortByCriteria(
    String criteria,
    ProductCategory category, [
    List<FinancialProduct>? prdt,
  ]) {
    final products =
        prdt ?? ((state.value == null) ? [] : [...state.value!.$2]);

    switch (ctg) {
      case ProductCategory.deposit:
      case ProductCategory.installment:
        final isHighest = (criteria == "최고 금리(높은 순)");
        final criteriaRate = products.map((e) {
          final targetRate = isHighest
              ? (e as DepositAndInstallmentSavings).maxPrfRate
              : (e as DepositAndInstallmentSavings).maxBaseRate;
          return (product: e, rate: targetRate);
        }).toList();
        criteriaRate.sort((a, b) {
          if (a.rate == null && b.rate == null) return 0;
          if (a.rate == null) return 1;
          if (b.rate == null) return -1;

          final comparison = b.rate!.compareTo(a.rate!);
          if (comparison != 0) return comparison;

          return a.product.commonInfo.productName!.compareTo(
            b.product.commonInfo.productName!,
          );
        });
        final sorted = criteriaRate.map((e) => e.product).toList();
        return sorted;

      case ProductCategory.mortgage:
      case ProductCategory.rent:
        final index = switch (criteria) {
          "최저 금리(낮은 순)" => 0, // 기본값(default value)
          "최고 금리(낮은 순)" => 2,
          _ => 1,
        };

        final criteriaRate = products.map((e) {
          final targetRate = switch (index) {
            0 => (e as MortgageAndRentLoan).minRate,
            1 => (e as MortgageAndRentLoan).avgRate,
            _ => (e as MortgageAndRentLoan).maxRate,
          };
          return (product: e, rate: targetRate);
        }).toList();

        criteriaRate.sort((a, b) {
          if (a.rate == null && b.rate == null) return 0;
          if (a.rate == null) return 1;
          if (b.rate == null) return -1;

          final comparison = a.rate!.compareTo(b.rate!);
          if (comparison != 0) return comparison;

          return a.product.commonInfo.productName!.compareTo(
            b.product.commonInfo.productName!,
          );
        });

        final sorted = criteriaRate.map((e) => e.product).toList();
        return sorted;

      case ProductCategory.credit:
        final index = switch (criteria) {
          "최저 금리(낮은 순)" => 0, // 기본값(default value)
          "최고 금리(낮은 순)" => 2,
          _ => 1,
        };
        final criteriaRate = products.map((e) {
          final targetRate = switch (index) {
            0 => (e as CreditLoan).minRate,
            1 => (e as CreditLoan).avgRate,
            _ => (e as CreditLoan).maxRate,
          };
          return (product: e, rate: targetRate);
        }).toList();

        criteriaRate.sort((a, b) {
          if (a.rate == null && b.rate == null) return 0;
          if (a.rate == null) return 1;
          if (b.rate == null) return -1;

          final comparison = a.rate!.compareTo(b.rate!);
          if (comparison != 0) return comparison;

          return a.product.commonInfo.productName!.compareTo(
            b.product.commonInfo.productName!,
          );
        });

        final sorted = criteriaRate.map((e) => e.product).toList();
        return sorted;

      case ProductCategory.isaMp:
        final isAvg = (criteria == "평균 수익률(높은 순)");

        final criteriaRate = products.map((e) {
          final targetRate = isAvg
              ? (e as IsaMpBenefitRate).avgProfit
              : (e as IsaMpBenefitRate).medProfit;
          return (product: e, rate: targetRate);
        }).toList();
        criteriaRate.sort((a, b) {
          if (a.rate == null && b.rate == null) return 0;
          if (a.rate == null) return 1;
          if (b.rate == null) return -1;

          final comparison = b.rate!.compareTo(a.rate!);
          if (comparison != 0) return comparison;

          return a.product.commonInfo.productName!.compareTo(
            b.product.commonInfo.productName!,
          );
        });

        final sorted = criteriaRate.map((e) => e.product).toList();
        return sorted;

      default:
        return [];
    }
  }

  // 검색창을 통해 키워드로 필터링하기
  // Filter by keyword using search bar
  void filterByKeyword(String keyword) {
    // 키워드가 있으면 필터링 적용
    // Apply filter when there's keyword
    if (keyword.isNotEmpty) {
      final currentState = state.value ?? (0, <FinancialProduct>[]);
      state = AsyncValue.data((
        currentState.$1,
        currentState.$2
            .where((e) => e.commonInfo.productName!.contains(keyword))
            .toList(),
      ));
      // 키워드가 없으면 원본 데이터 불러오기
      // If no keyword, fetch original data
    } else {
      final page = ref.read(currentPageViewmodelProvider(ctg));
      final original = ref.read(fetchProductViewmodelProvider(ctg, page));
      final criteria = ref.read(sortOrFilterTextViewModelProvider(ctg));
      final maxPage = (original.value == null) ? 0 : original.value!.$1;
      final products = (original.value == null)
          ? <FinancialProduct>[]
          : original.value!.$2;
      final sorted = sortByCriteria(criteria.$1.toString(), ctg, products);
      state = AsyncValue.data((maxPage, sorted));
    }
  }
}
