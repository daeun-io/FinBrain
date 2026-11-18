import 'dart:async';
import 'package:finbrain/data/google_auth_service.dart';
import 'package:finbrain/data/model/entities/business_loan.dart';
import 'package:finbrain/data/model/entities/credit_loan.dart';
import 'package:finbrain/data/model/entities/deposit_and_installment_savings.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/model/entities/isa_mp_benefit_rate.dart';
import 'package:finbrain/data/model/entities/mortgage_and_rent_loan.dart';
import 'package:finbrain/data/repository/product_repository.dart';
import 'package:finbrain/ui/viewmodel/selected_parameter_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/sort_or_filter_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/filters_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/liked_product_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:flutter/material.dart';
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
  Future<List<FinancialProduct>> build(ProductCategory ctg) async {
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

      final filters = ref.watch(savedFiltersProvider(ctg));
      // 선택된 필터 추출
      // Extract selected filter value
      if (filters.value != null) {
        Map<String, List<String>> selectedFilters = {};
        for (final entry in filters.value!.entries) {
          selectedFilters[entry.key] = entry.value
              .where((e) => e.$2 == true)
              .map((e) => e.$1)
              .toList();
        }
        
        if (filters.value!["회사 선택"] != null) {
          final companies = filters.value!["회사 선택"]!
              .where((element) => element.$2 == true)
              .map(
                (e) => switch (topFinGrpNo) {
                  "050000" => (e.$1 != "생명보험협회") ? "${e.$1}주식회사" : e.$1,
                  "030200" => switch (e.$1) {
                    "오케이캐피탈" => "오케이캐피탈 ㈜",
                    "아이비케이캐피탈" ||
                    "애큐온캐피탈" ||
                    "에이치비캐피탈" ||
                    "아이엠캐피탈" ||
                    "에코캐피탈" ||
                    "케이비국민카드" ||
                    "우리카드" ||
                    "블루코너캐피탈" ||
                    "마스턴캐피탈" => "㈜${e.$1}",
                    _ => "${e.$1}㈜",
                  },
                  "020000" => switch (e.$1) {
                    "농협은행" => "농협은행주식회사",
                    "토스뱅크" => "토스뱅크 주식회사",
                    "하나은행" || "케이뱅크" || "카카오뱅크" => "주식회사 ${e.$1}",
                    _ => e.$1,
                  },
                  _ => e.$1,
                },
              )
              .toList();
          selectedFilters["회사 선택"] = companies;
        }

        return (ctg == ProductCategory.isaMp)
            ? await repository.fetchIsaProducts(
                user.uid,
                baseYear.toString(),
                selectedFilters["업권"],
                selectedFilters["MP 종류"],
              )
            : await repository.fetchFinlifeProductsAndPageNo(
                user.uid,
                ctg,
                topFinGrpNo,
                selectedFilters["회사 선택"],
                selectedFilters["가입 방법"],
              );
      } else {
        debugPrint("[null] filter is null");
        throw Exception("[null] filter is null");
      }
    } catch (e) {
      debugPrint("[error] failed to load financial products : $e");
      throw Exception("[error] failed to load financial products : $e");
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
      final updated = data
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
      state = AsyncValue.data(updated);

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
  AsyncValue<List<FinancialProduct>> build(ProductCategory ctg) {
    // 데이터, 필터, 기준 관찰하기
    // Watch data, filter and sorting criteria
    final criteria = ref.watch(sortOrFilterTextViewModelProvider(ctg));
    final result = ref.watch(fetchProductViewmodelProvider(ctg));

    return result.when(
      data: (data) {
        final sorted = sortByCriteria(criteria.$1.toString(), result.value);
        return AsyncData(sorted);
      },
      error: (error, stackTrace) => AsyncError(error, stackTrace),
      loading: () => const AsyncLoading(),
    );
  }

  // 데이터 정렬하기
  // Sort data by criteria
  List<FinancialProduct> sortByCriteria(
    String criteria, [
    List<FinancialProduct>? prdt,
  ]) {
    final products = prdt ?? ((state.value == null) ? [] : [...state.value!]);

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

      case ProductCategory.business:
        final index = switch (criteria) {
          "최저 적용 이자율(낮은 순)" => 0, // 기본값(default value)
          "최고 적용 이자율(낮은 순)" => 2,
          _ => 1,
        };

        final criteriaRate = products.map((e) {
          final targetRate = switch (index) {
            0 => (e as BusinessLoan).options[0].minRate,
            1 => (e as BusinessLoan).options[0].avgRate,
            _ => (e as BusinessLoan).options[0].maxRate,
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
        final isMin = (criteria == "최저 수익률(높은 순)");

        final criteriaRate = products.map((e) {
          final targetRate = isMin
              ? (e as IsaMpBenefitRate).minProfit
              : (e as IsaMpBenefitRate).maxProfit;
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
      final currentState = state.value ?? [];
      state = AsyncValue.data(
        currentState
            .where((e) => e.commonInfo.productName!.contains(keyword))
            .toList(),
      );
      // 키워드가 없으면 원본 데이터 불러오기
      // If no keyword, fetch original data
    } else {
      final original = ref.read(fetchProductViewmodelProvider(ctg));
      final criteria = ref.read(sortOrFilterTextViewModelProvider(ctg));
      final products = original.value;
      final sorted = sortByCriteria(criteria.$1.toString(), products);
      state = AsyncValue.data(sorted);
    }
  }
}
