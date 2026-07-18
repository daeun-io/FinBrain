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

final repository = IsaRepository();

@riverpod
class FetchIsaJoinStatusViewmodel extends _$FetchIsaJoinStatusViewmodel {
  @override
  Future<(int, List<IsaJoinStatus>)> build(String pageNo) async {
    try {
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

      final result = await repository.fetchJoinStatus(pageNo, "200", baseYear);

      final totalCount = result.$1;
      final status = result.$2;
      final filtered = status.where((element) {
        return (selectedFilters["업권"] ?? []).contains(element.category) &&
            (selectedFilters["ISA 형태"] ?? []).contains(element.isaForm);
      }).toList();

      return (totalCount, filtered);
    } catch (e) {
      throw Exception("[error] failed to isa join status : $e");
      // debugPrint("[error] failed to fetch isa join status : $e");
      // return (-1, <IsaJoinStatus>[]);
    }
  }
}

@riverpod
class IsaJoinStatusViewModel extends _$IsaJoinStatusViewModel {
  @override
  AsyncValue<(int, List<IsaJoinStatus>)> build() {
    final cPage = ref.watch(currentPageViewmodelProvider(ProductCategory.isaJoin));
    final result = ref.watch(fetchIsaJoinStatusViewmodelProvider("$cPage"));
    final criteria = ref
        .read(sortOrFilterTextViewModelProvider(ProductCategory.isaJoin))
        .$1
        .toString();

    return result.when(
      data: (data) {
        final sorted = List<IsaJoinStatus>.from(data.$2);
        sorted.sort((a, b) {
          switch (criteria) {
            case "회사 수(오름차순)":
              return a.companyCount!.compareTo(b.companyCount!);
            case "회사 수(내림차순)":
              return b.companyCount!.compareTo(a.companyCount!);
            case "가입자 수(내림차순)":
              return a.joinMemberCount!.compareTo(b.joinMemberCount!);
            default:
              return b.joinMemberCount!.compareTo(a.joinMemberCount!);
          }
        });
        return AsyncValue.data((data.$1, sorted));
      },
      loading: () => const AsyncValue.loading(),
      error: (error, stackTrace) => AsyncValue.error(
        "[error] failed to fetch isa join status, $error",
        stackTrace,
      ),
    );
  }

  AsyncValue<(int, List<IsaJoinStatus>)> sortByCriteria(
    String criteria,
    int totalCount, [
    List<IsaJoinStatus>? status,
  ]) {
    final isaJoinData =
        status ?? ((state.value == null) ? [] : [...state.value!.$2]);
    final sorted = AsyncData((
      totalCount,
      isaJoinData..sort(switch (criteria) {
        "회사 수(오름차순)" => (a, b) => a.companyCount!.compareTo(b.companyCount!),
        "회사 수(내림차순)" => (a, b) => b.companyCount!.compareTo(a.companyCount!),
        "가입자 수(오름차순)" => (a, b) => a.joinMemberCount!.compareTo(
          b.joinMemberCount!,
        ),
        _ => (a, b) => b.joinMemberCount!.compareTo(a.joinMemberCount!),
      }),
    ));
    state = sorted;
    return sorted;
  }
}

@riverpod
class FetchIsaMngmStatusViewmodel extends _$FetchIsaMngmStatusViewmodel {
  @override
  Future<(int, List<IsaManagementStatus>)> build(String pageNo) async {
    try {
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

      final result = await repository.fetchManagementStatus(
        pageNo,
        "200",
        baseYear,
        (selectedFilters["구분"]?.first ?? "비중"),
      );

      final totalCount = result.$1;
      final status = result.$2;
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

@riverpod
class IsaManagementStatusViewModel extends _$IsaManagementStatusViewModel {
  @override
  AsyncValue<(int, List<IsaManagementStatus>)> build() {
    final cPage = ref.watch(currentPageViewmodelProvider(ProductCategory.isaManagement));
    final result = ref.watch(fetchIsaMngmStatusViewmodelProvider("$cPage"));
    final criteria = ref
        .read(sortOrFilterTextViewModelProvider(ProductCategory.isaManagement))
        .$1
        .toString();

    return result.when(
      data: (data) => sortByCriteria(criteria, data.$1, data.$2),
      error: (error, stackTrace) => AsyncValue.error(
        "[error] failed to fetch isa management status",
        stackTrace,
      ),
      loading: () => const AsyncValue.loading(),
    );
  }

  AsyncValue<(int, List<IsaManagementStatus>)> sortByCriteria(
    String criteria,
    int totalCount, [
    List<IsaManagementStatus>? status,
  ]) {
    final isaMnData =
        status ?? ((state.value == null) ? [] : [...state.value!.$2]);

    final sorted = AsyncData((
      totalCount,
      isaMnData..sort(
        (a, b) => (criteria == "금액/비율(오름차순)")
            ? a.amount!.compareTo(b.amount!)
            : b.amount!.compareTo(a.amount!),
      ),
    ));
    state = sorted;
    return sorted;
  }
}
