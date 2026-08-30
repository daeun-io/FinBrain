import 'package:finbrain/data/data_source/user_data_source.dart';
import 'package:finbrain/data/google_auth_service.dart';
import 'package:finbrain/data/model/entities/isa_join_status.dart';
import 'package:finbrain/data/model/entities/isa_management_status.dart';
import 'package:finbrain/data/repository/isa_repository.dart';
import 'package:finbrain/ui/viewmodel/current_page_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/filters_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/sort_or_filter_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'isa_viewmodel.g.dart';

// ISA 다모아 데이터 레포지토리
// Repository for ISA join and management status
final repository = IsaRepository();

// ISA 가입 현황 가져오는 뷰모델
// Fetching ISA join status viewmodel
@riverpod
class FetchIsaJoinStatusViewmodel extends _$FetchIsaJoinStatusViewmodel {
  @override
  Future<(int, List<IsaJoinStatus>)> build(int pageNo) async {
    try {
      // 저장한 필터 관찰하기
      // Watch saved filter
      final filters = ref.watch(savedFiltersProvider(ProductCategory.isaJoin));
      Map<String, List<String>> selectedFilters = {};
      for (final entry in (filters.value ?? {}).entries) {
        selectedFilters[entry.key] = entry.value
            .where((e) => e.$2 == true)
            .map((e) => e.$1)
            .toList();
      }
      final baseYear = (selectedFilters["기준년도"]?.isNotEmpty ?? false)
          ? selectedFilters["기준년도"]!.first
          : DateTime.now().year.toString();

      // ISA 가입 현황 데이터 호출하기
      // Fetch ISA join status
      final result = await repository.fetchJoinStatus(
        pageNo.toString(),
        "200",
        baseYear,
      );

      final totalCount = result.$1;
      final status = result.$2;
      // 필터 적용하기
      // Apply filter to data
      final filtered = status.where((element) {
        return (selectedFilters["업권"] ?? []).contains(element.category) &&
            (selectedFilters["ISA 형태"] ?? []).contains(element.isaForm);
      }).toList();

      return (totalCount, filtered);
    } catch (e) {
      debugPrint("[error] failed to isa join status : $e");
      throw Exception("[error] failed to isa join status : $e");
    }
  }
}

// ISA 운용 현황 가져오는 뷰모델
// Fetching ISA management status viewmodel
@riverpod
class FetchIsaMngmStatusViewmodel extends _$FetchIsaMngmStatusViewmodel {
  @override
  Future<(int, List<IsaManagementStatus>)> build(int pageNo) async {
    try {
      // 저장한 필터 관찰하기
      // Watch saved filter
      final filters = ref.watch(
        savedFiltersProvider(ProductCategory.isaManagement),
      );
      Map<String, List<String>> selectedFilters = {};
      for (final entry in (filters.value ?? {}).entries) {
        selectedFilters[entry.key] = entry.value
            .where((e) => e.$2 == true)
            .map((e) => e.$1)
            .toList();
      }

      final baseYear = (selectedFilters["기준년도"]?.isNotEmpty ?? false)
          ? selectedFilters["기준년도"]!.first
          : DateTime.now().year.toString();

      // ISA 운용 현황 데이터 호출하기
      // Fetch ISA management status
      final result = await repository.fetchManagementStatus(
        pageNo.toString(),
        "200",
        baseYear,
        (selectedFilters["구분"]?.first ?? "비중"),
      );

      final totalCount = result.$1;
      final status = result.$2;
      // 필터 적용하기
      // Apply filter to data
      final filtered = status.where((element) {
        return (selectedFilters["업권"] ?? []).contains(element.businessDomain) &&
            (selectedFilters["ISA 형태"] ?? []).contains(element.isaForm) &&
            (selectedFilters["구분"] ?? []).contains(element.category);
      }).toList();

      return (totalCount, filtered);
    } catch (e) {
      debugPrint("[error] failed to fetch isa management status : $e");
      return (-1, <IsaManagementStatus>[]);
    }
  }
}

// 화면에 ISA 가입/운용 현황 보이는 뷰모델
// Displaying ISA join/management status in screen
@riverpod
class IsaStatusViewmodel extends _$IsaStatusViewmodel {
  @override
  AsyncValue<(int, List<Object>)> build(ProductCategory category) {
    // 데이터 뷰모델 관찰하기
    // Watch fetching isa join status viewmodel
    final cPage = ref.watch(currentPageViewmodelProvider(category));
    final result = (category == ProductCategory.isaJoin)
        ? ref.watch(fetchIsaJoinStatusViewmodelProvider(cPage))
        : ref.watch(fetchIsaMngmStatusViewmodelProvider(cPage));
    // 정렬 기준 읽기
    // Read sort criteria
    final criteria = ref.watch(sortOrFilterTextViewModelProvider(category));

    // 정렬 기준 적용하기
    // Apply sorting criteria to data
    return result.when(
      data: (data) {
        final (totalCount, status) = data;
        final sorted = sortByCriteria(criteria.$1.toString(), category, status);
        return AsyncValue.data((totalCount, sorted));
      },
      loading: () => const AsyncValue.loading(),
      error: (error, stackTrace) => AsyncValue.error(
        "[error] failed to fetch isa join status, $error",
        stackTrace,
      ),
    );
  }

  // 데이터 정렬하는 함수
  // Function that sorts ISA join status
  List<Object> sortByCriteria(
    String criteria,
    ProductCategory category, [
    List<Object>? status,
  ]) {
    final isaStatus =
        status ?? ((state.value == null) ? [] : [...state.value!.$2]);
    if (category == ProductCategory.isaJoin) {
      final joinStatus = List.of(isaStatus as List<IsaJoinStatus>) ;
      final sorted = joinStatus
        ..sort(switch (criteria) {
          "회사 수(오름차순)" => (a, b) {
            if (a.companyCount == null && b.companyCount == null) {
              return 0;
            }
            if (a.companyCount == null) return 1;
            if (b.companyCount == null) return -1;

            final comparison = a.companyCount!.compareTo(b.companyCount!);
            return comparison;
          },
          "회사 수(내림차순)" => (a, b) {
            if (a.companyCount == null && b.companyCount == null) {
              return 0;
            }

            if (a.companyCount == null) return 1;
            if (b.companyCount == null) return -1;

            final comparison = b.companyCount!.compareTo(a.companyCount!);
            return comparison;
          },
          "가입자 수(오름차순)" => (a, b) {
            if (a.joinMemberCount == null && b.joinMemberCount == null) {
              return 0;
            }

            if (a.joinMemberCount == null) return 1;
            if (b.joinMemberCount == null) return -1;

            final comparison = a.joinMemberCount!.compareTo(b.joinMemberCount!);
            return comparison;
          },
          _ => (a, b) {
            if (a.joinMemberCount == null && b.joinMemberCount == null) {
              return 0;
            }

            if (a.joinMemberCount == null) return 1;
            if (b.joinMemberCount == null) return -1;

            final comparison = b.joinMemberCount!.compareTo(a.joinMemberCount!);
            return comparison;
          },
        });
      return sorted;
    } else {
      final mngmStatus = List.of(isaStatus as List<IsaManagementStatus>);
      final sorted = mngmStatus
        ..sort(
          (criteria == "금액/비율(오름차순)")
              ? ((a, b) {
                  if (a.amount == null && b.amount == null) {
                    return 0;
                  }

                  if (a.amount == null) return 1;
                  if (b.amount == null) return -1;
                  return a.amount!.compareTo(b.amount!);
                })
              : ((a, b) {
                  if (a.amount == null && b.amount == null) {
                    return 0;
                  }
                  if (a.amount == null) return 1;
                  if (b.amount == null) return -1;
                  return b.amount!.compareTo(a.amount!);
                }),
        );
      return sorted;
    }
  }

}

// 파이어스토어의 ISA 튜토리얼 패러미터 다루기
// Handle isa tutorial params in Firestore
@riverpod
class IsaTutorialViemodel extends _$IsaTutorialViemodel {
  final userDataSource = UserDataSource();

  @override
  Future<bool> build() async {
    final user = GoogleAuthService.getCurrentUser();
    if(user == null || user.displayName == null || user.email == null) return true;
    return userDataSource.readIsaTutorial(user);
  }

  Future<void> setReadIsaTutorialToTrue() async {
    final user = GoogleAuthService.getCurrentUser();
    if(user == null || user.email == null || user.displayName == null) return;
    return userDataSource.setReadIsaTutorialToTrue();
  }
}
