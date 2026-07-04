import 'package:finbrain/data/model/entities/isa_join_status.dart';
import 'package:finbrain/data/model/entities/isa_management_status.dart';
import 'package:finbrain/data/repository/isa_repository.dart';
import 'package:finbrain/ui/viewmodel/filters_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/sort_or_filter_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'isa_viewmodel.g.dart';

final repository = IsaRepository();

@riverpod
class IsaJoinStatusViewModel extends _$IsaJoinStatusViewModel {
  @override
  Future<(int, List<IsaJoinStatus>)> build() async {
    return (0, <IsaJoinStatus>[]);
  }

  void fetchIsaJoinStatus(
    String pageNo, [
    Map<String, List<(String, bool)>>? snapshot,
  ]) async {
    final filters =
        snapshot ??
        (await ref.read(
              filtersViewmodelProvider(FilterTextCategory.isaJoin).future,
            ) ??
            {});

    Map<String, List<String>> selectedFilters = {};
    for (final entry in filters.entries) {
      selectedFilters[entry.key] = entry.value
          .where((e) => e.$2 == true)
          .map((e) => e.$1)
          .toList();
    }

    final joinStatus = await repository.fetchJoinStatus(
      pageNo,
      "100",
      // todo: change later
      DateTime.now().year.toString(),
    );

    final totalCount = joinStatus.$1;
    final status = joinStatus.$2;
    final filtered = status.where((element) {
      return (selectedFilters["업권"] ?? []).contains(element.category) &&
          (selectedFilters["ISA 형태"] ?? []).contains(element.isaForm);
    }).toList();

    print("=====================");
    print("joinStatus count, ${joinStatus.$1}");
    print("selected filters, $selectedFilters");
    print("filtered data, $filtered");
    print("=====================");

    final criteria = ref
        .read(sortOrFilterTextViewModelProvider(FilterTextCategory.isaJoin))
        .$1
        .toString();

    sortByCriteria(criteria, totalCount, filtered);
  }

  void sortByCriteria(
    String criteria,
    int totalCount, [
    List<IsaJoinStatus>? status,
  ]) {
    final isaJoinData =
        status ?? ((state.value == null) ? [] : state.value!.$2);

    state = AsyncData((
      totalCount,
      isaJoinData..sort(switch (criteria) {
        "회사 수(오름차순)" => (a, b) => a.companyCount!.compareTo(b.companyCount!),
        "회사 수(내림차순)" => (b, a) => b.companyCount!.compareTo(a.companyCount!),
        "가입자 수(오름차순)" => (a, b) => a.joinMemberCount!.compareTo(
          b.joinMemberCount!,
        ),
        _ => (a, b) => b.joinMemberCount!.compareTo(a.joinMemberCount!),
      }),
    ));
  }
}

@riverpod
class IsaManagementStatusViewModel extends _$IsaManagementStatusViewModel {
  @override
  Future<(int, List<IsaManagementStatus>)> build() async {
    return (0, <IsaManagementStatus>[]);
  }

  void fetchIsaManagementStatus(
    String pageNo, [
    Map<String, List<(String, bool)>>? snapshot,
  ]) async {
    final filters =
        snapshot ??
        (await ref.read(
              filtersViewmodelProvider(FilterTextCategory.isaManagement).future,
            ) ??
            {});

    Map<String, List<String>> selectedFilters = {};
    for (final entry in filters.entries) {
      selectedFilters[entry.key] = entry.value
          .where((e) => e.$2 == true)
          .map((e) => e.$1)
          .toList();
    }

    final mngmStatus = await repository.fetchManagementStatus(
      pageNo,
      "100",
      // todo: change later
      DateTime.now().year.toString(),
      (selectedFilters["구분"]?.first ?? "비중"),
    );

    final totalCount = mngmStatus.$1;
    final status = mngmStatus.$2;
    final filtered = status.where((element) {
      return (selectedFilters["업권"] ?? []).contains(element.businessDomain) &&
          (selectedFilters["ISA 형태"] ?? []).contains(element.isaForm);
    }).toList();

    final criteria = ref
        .read(sortOrFilterTextViewModelProvider(FilterTextCategory.isaJoin))
        .$1
        .toString();

    sortByCriteria(criteria, totalCount, filtered);
  }

  void sortByCriteria(
    String criteria,
    int totalCount, [
    List<IsaManagementStatus>? status,
  ]) {
    final isaMnData =
        status ?? ((state.value == null) ? [] : state.value!.$2);

    state = AsyncData((
      totalCount,
      isaMnData..sort(
        (a, b) => (criteria == "금액/비율(오름차순)")
            ? a.amount!.compareTo(b.amount!)
            : b.amount!.compareTo(a.amount!),
      ),
    ));
  }
}
