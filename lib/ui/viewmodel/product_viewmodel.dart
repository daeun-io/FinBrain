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
    String pageNo,
  ) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        throw Exception("[user] no user found");
      }
      // 저장한 필터 관찰하기
      // Watch saved filter
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
              "100",
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
  AsyncValue<(int, List<FinancialProduct>)> build(
    ProductCategory ctg,
  ) {
    // 데이터 및 기준 관찰하기
    // Watch data and sorting criteria
    final cPage = ref.watch(currentPageViewmodelProvider(ctg));
    final criteria = ref
        .watch(sortOrFilterTextViewModelProvider(ctg))
        .$1
        .toString();
    final result = ref.watch(fetchProductViewmodelProvider(ctg, "$cPage"));

    // 데이터 필터링하기
    // Filter financial products
    return result.when(
      data: (data) {
        final sorted = List<FinancialProduct>.from(data.$2);
        sorted.sort((a, b) {
          switch (ctg) {
            case ProductCategory.deposit:
            case ProductCategory.installment:
              final isHighest = (criteria == "최고 금리(높은 순)");
              final aRate = isHighest
                  ? (a as DepositAndInstallmentSavings)
                        .returnHighestRateValue()
                        .$1
                  : (a as DepositAndInstallmentSavings)
                        .returnHighestRateValue()
                        .$2;
              final bRate = isHighest
                  ? (b as DepositAndInstallmentSavings)
                        .returnHighestRateValue()
                        .$1
                  : (b as DepositAndInstallmentSavings)
                        .returnHighestRateValue()
                        .$2;

              if (aRate == null && bRate == null) return 0;
              if (aRate == null) return 1;
              if (bRate == null) return -1;

              final comparison = bRate.compareTo(aRate);
              if (comparison != 0) return comparison;

              return a.commonInfo.productName!.compareTo(
                b.commonInfo.productName!,
              );

            case ProductCategory.mortgage:
            case ProductCategory.rent:
              int index = 1; // 기본값(default value)

              if (criteria == "최저 금리(낮은 순)") {
                index = 0;
              } else if (criteria == "최고 금리(낮은 순)") {
                index = 2;
              } else {
                index = 1;
              }

              final aRate = (a as MortgageAndRentLoan).returnRates()[index];
              final bRate = (b as MortgageAndRentLoan).returnRates()[index];

              if (aRate == null && bRate == null) return 0;
              if (aRate == null) return 1;
              if (bRate == null) return -1;

              final comparison = aRate.compareTo(bRate);
              if (comparison != 0) return comparison;

              return a.commonInfo.productName!.compareTo(
                b.commonInfo.productName!,
              );

            case ProductCategory.credit:
              int index = 1;
              if (criteria == "최저 금리(낮은 순)") {
                index = 0;
              } else if (criteria == "최고 금리(낮은 순)") {
                index = 2;
              } else {
                index = 1;
              }

              final aRate = (a as CreditLoan).returnRates()[index];
              final bRate = (b as CreditLoan).returnRates()[index];

              if (aRate == null && bRate == null) return 0;
              if (aRate == null) return 1;
              if (bRate == null) return -1;

              final comparison = aRate.compareTo(bRate);
              if (comparison != 0) return comparison;

              return a.commonInfo.productName!.compareTo(
                b.commonInfo.productName!,
              );

            default:
              final isAvg = (criteria == "평균 수익률(높은 순)");
              final aRate = isAvg
                  ? (a as IsaMpBenefitRate).returnAvgMedProfits().$1
                  : (a as IsaMpBenefitRate).returnAvgMedProfits().$2;
              final bRate = isAvg
                  ? (b as IsaMpBenefitRate).returnAvgMedProfits().$1
                  : (b as IsaMpBenefitRate).returnAvgMedProfits().$2;


              final comparison = bRate.compareTo(aRate);
              if (comparison != 0) return comparison;

              return a.commonInfo.productName!.toLowerCase().compareTo(
                b.commonInfo.productName!.toLowerCase(),
              );
          }
        });
        return AsyncValue.data((data.$1, sorted));
      },
      error: (error, stackTrace){
        return AsyncValue.error("[error] failed to fetch financial products, $error", stackTrace);
      },
      loading: () => const AsyncValue.loading(),
    );
  }

  // 데이터 정렬하기
  // Sort data by criteria
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
        List<FinancialProduct>.from(products)..sort(
          (criteria == "최고 금리(높은 순)")
              ? (a, b) {
                  final aRate = (a as DepositAndInstallmentSavings)
                      .returnHighestRateValue()
                      .$1;
                  final bRate = (b as DepositAndInstallmentSavings)
                      .returnHighestRateValue()
                      .$1;

                  if (aRate == null && bRate == null) return 0;
                  if (aRate == null) return 1;
                  if (bRate == null) return -1;

                  final comparison = bRate.compareTo(aRate);
                  if (comparison != 0) {
                    return comparison;
                  }
                  return a.commonInfo.productName!.compareTo(
                    b.commonInfo.productName!,
                  );
                }
              : (a, b) {
                  final aRate = (a as DepositAndInstallmentSavings)
                      .returnHighestRateValue()
                      .$2;
                  final bRate = (b as DepositAndInstallmentSavings)
                      .returnHighestRateValue()
                      .$2;

                  if (aRate == null && bRate == null) return 0;
                  if (aRate == null) return 1;
                  if (bRate == null) return -1;

                  final comparison = bRate.compareTo(aRate);
                  if (comparison != 0) {
                    return comparison;
                  }
                  return a.commonInfo.productName!.compareTo(
                    b.commonInfo.productName!,
                  );
                },
        ),
      )),
      ProductCategory.mortgage || ProductCategory.rent => AsyncValue.data((
        maxPage,
        List<FinancialProduct>.from(products)..sort(switch (criteria) {
          "최저 금리(낮은 순)" => (a, b) {
            final aRate = (a as MortgageAndRentLoan).returnRates()[0];
            final bRate = (b as MortgageAndRentLoan).returnRates()[0];

            if (aRate == null && bRate == null) return 0;
            if (aRate == null) return 1;
            if (bRate == null) return -1;

            final comparison = aRate.compareTo(bRate);
            if (comparison != 0) {
              return comparison;
            }
            return a.commonInfo.productName!.compareTo(
              b.commonInfo.productName!,
            );
          },
          "최고 금리(낮은 순)" => (a, b) {
            final aRate = (a as MortgageAndRentLoan).returnRates()[2];
            final bRate = (b as MortgageAndRentLoan).returnRates()[2];

            if (aRate == null && bRate == null) return 0;
            if (aRate == null) return 1;
            if (bRate == null) return -1;

            final comparison = aRate.compareTo(bRate);
            if (comparison != 0) {
              return comparison;
            }
            return a.commonInfo.productName!.compareTo(
              b.commonInfo.productName!,
            );
          },
          _ => (a, b) {
            final aRate = (a as MortgageAndRentLoan).returnRates()[1];
            final bRate = (b as MortgageAndRentLoan).returnRates()[1];

            if (aRate == null && bRate == null) return 0;
            if (aRate == null) return 1;
            if (bRate == null) return -1;

            final comparison = aRate.compareTo(bRate);
            if (comparison != 0) {
              return comparison;
            }
            return a.commonInfo.productName!.compareTo(
              b.commonInfo.productName!,
            );
          },
        }),
      )),
      ProductCategory.credit => AsyncValue.data((
        maxPage,
        List<FinancialProduct>.from(products)..sort(switch (criteria) {
          "최저 금리(낮은 순)" => (a, b) {
            final aRate = (a as CreditLoan).returnRates()[0];
            final bRate = (b as CreditLoan).returnRates()[0];

            if (aRate == null && bRate == null) return 0;
            if (aRate == null) return 1;
            if (bRate == null) return -1;

            final comparison = aRate.compareTo(bRate);
            if (comparison != 0) {
              return comparison;
            }
            return a.commonInfo.productName!.compareTo(
              b.commonInfo.productName!,
            );
          },
          "최고 금리(낮은 순)" => (a, b) {
            final aRate = (a as CreditLoan).returnRates()[2];
            final bRate = (b as CreditLoan).returnRates()[2];

            if (aRate == null && bRate == null) return 0;
            if (aRate == null) return 1;
            if (bRate == null) return -1;

            final comparison = aRate.compareTo(bRate);
            if (comparison != 0) {
              return comparison;
            }
            return a.commonInfo.productName!.compareTo(
              b.commonInfo.productName!,
            );
          },
          _ => (a, b) {
            final aRate = (a as CreditLoan).returnRates()[1];
            final bRate = (b as CreditLoan).returnRates()[1];

            if (aRate == null && bRate == null) return 0;
            if (aRate == null) return 1;
            if (bRate == null) return -1;

            final comparison = aRate.compareTo(bRate);
            if (comparison != 0) {
              return comparison;
            }
            return a.commonInfo.productName!.compareTo(
              b.commonInfo.productName!,
            );
          },
        }),
      )),
      _ => AsyncData((
        maxPage,
        List<FinancialProduct>.from(products)..sort(switch (criteria) {
          "평균 수익률(높은 순)" => (a, b) {
            final comparison = (b as IsaMpBenefitRate)
                .returnAvgMedProfits()
                .$1
                .compareTo((a as IsaMpBenefitRate).returnAvgMedProfits().$1);
            if (comparison == 0) {
              return a.commonInfo.productName!.toLowerCase().compareTo(
                b.commonInfo.productName!.toLowerCase(),
              );
            } else {
              return comparison;
            }
          },
          _ => (a, b) {
            final comparison = (b as IsaMpBenefitRate)
                .returnAvgMedProfits()
                .$2
                .compareTo((a as IsaMpBenefitRate).returnAvgMedProfits().$2);
            if (comparison == 0) {
              return a.commonInfo.productName!.toLowerCase().compareTo(
                b.commonInfo.productName!.toLowerCase(),
              );
            } else {
              return comparison;
            }
          },
        }),
      )),
    };
    state = sorted;
    return sorted;
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
