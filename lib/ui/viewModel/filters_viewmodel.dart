import 'dart:async';

import 'package:finbrain/data/converter.dart';
import 'package:finbrain/data/repository/filters_repository.dart';
import 'package:finbrain/ui/viewmodel/isa_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/selected_topFinGrpNo_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'filters_viewmodel.g.dart';

final repository = FiltersRepository();

@riverpod
class FiltersViewmodel extends _$FiltersViewmodel {
  @override
  Future<Map<String, List<(String, bool)>>> build(
    FilterTextCategory ctg,
  ) async {
    final topFinGrpMap = ref.watch(selectedTopfingrpnoViewmodelProvider);
    final topFinGrpNo =
        topFinGrpMap[switch (ctg) {
          FilterTextCategory.savings => "예적금",
          FilterTextCategory.loan => "대출",
          FilterTextCategory.annuity => "연금저축",
          _ => "",
        }] ??
        "020000";
    return await repository.fetchFilters(ctg, topFinGrpNo);
  }
}

@riverpod
class DialogFiltersViewModel extends _$DialogFiltersViewModel {
  @override
  Map<String, List<(String, bool)>> build(FilterTextCategory ctg) {
    final currentSaved = ref.read(savedFiltersProvider(ctg));
    print("currentSaved: $currentSaved");
    if (currentSaved.isEmpty) {
      fetchInitialFilters(ctg);
      return {};
    }
    return Map<String, List<(String, bool)>>.from(currentSaved);
  }

  Future<void> fetchInitialFilters(FilterTextCategory ctg) async {
    try {
      final data = await ref.read(filtersViewmodelProvider(ctg).future);
      if (data.isNotEmpty) {
        state = Map<String, List<(String, bool)>>.from(data);
      }
    } catch (error) {
      print("error: Failed to fetch filters, $error");
    }
  }

  Future<void> toggleSelected(String text, bool selected) async {
    final updated = {
      for (final entry in state.entries)
        if (entry.value.contains((text, selected)))
          entry.key: entry.value.map((e) {
            if (entry.key == "금융회사" || entry.key == "구분") {
              return e.$1 == text ? (e.$1, true) : (e.$1, false);
            }
            return e.$1 == text ? (e.$1, !selected) : e;
          }).toList()
        else
          entry.key: entry.value,
    };
    print("updated filters: $updated");

    final selectedFinGrp = updated["금융회사"];
    if (selectedFinGrp == null || selectedFinGrp == state["금융회사"]) {
      state = updated;
      return;
    }

    final sFinGrpName =
        selectedFinGrp.where((e) => e.$2).map((e) => e.$1).firstOrNull ?? "";
    final topFinGrpNo = getFinGroupCode[sFinGrpName] ?? "020000";

    try {
      final cmpyList = await repository.fetchCmpyNames(topFinGrpNo);
      state = {
        for (final entry in updated.entries)
          if (entry.key == "회사 선택")
            entry.key: cmpyList
                .map<(String, bool)>((e) => (e as String, false))
                .toList()
          else
            entry.key: entry.value,
      };
      print("filter: toggle state, $state");
    } catch (error) {
      print("Failed to fetch company list, $error");
      state = updated;
    }
  }

  Future<void> applyChanges(
    ProductCategory productCategory,
    String pageNo,[
      FilterTextCategory? filterCategory,
    ]
  ) async {
    final snapshot = Map<String, List<(String, bool)>>.from(state);
    ref.read(savedFiltersProvider(ctg).notifier).save(snapshot);
    if (productCategory != ProductCategory.isa) {
      ref
          .read(productViewmodelProvider.notifier)
          .fetchFinlifeProducts(productCategory, "1", snapshot);
    }else{
      switch(filterCategory){
        case FilterTextCategory.isaJoin: ref.read(isaJoinStatusViewModelProvider.notifier).fetchIsaJoinStatus(pageNo, snapshot);
        case FilterTextCategory.isaManagement: ref.read(isaManagementStatusViewModelProvider.notifier).fetchIsaManagementStatus(pageNo, snapshot);
        default: ref.read(productViewmodelProvider.notifier).fetchIsaMpProducts(pageNo, snapshot);
      }
    }
  }

  void resetChanges() {
    final filters = ref.read(savedFiltersProvider(ctg));
    state = filters;
  }
}

@Riverpod(keepAlive: true)
@riverpod
class SavedFilters extends _$SavedFilters {
  @override
  Map<String, List<(String, bool)>> build(FilterTextCategory ctg) => {};

  void save(Map<String, List<(String, bool)>> filters) => state = filters;
}
