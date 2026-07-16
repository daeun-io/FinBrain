import 'dart:async';
import 'package:finbrain/data/converter.dart';
import 'package:finbrain/data/repository/filters_repository.dart';
import 'package:finbrain/ui/viewmodel/selected_parameter_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/isa_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'filters_viewmodel.g.dart';

final repository = FiltersRepository();

@riverpod
class FiltersViewmodel extends _$FiltersViewmodel {
  @override
  Future<Map<String, List<(String, bool)>>> build(ProductCategory ctg) async {
    final topFinGrpMap = ref.watch(selectedTopFinGrpNoViewmodelProvider);
    final topFinGrpNo = topFinGrpMap[ctg] ?? "020000";

    final baseYearMap = ref.watch(selectedBaseYearViewmodelProvider);
    final baseYear = baseYearMap[ctg] ?? DateTime.now().year;
    return await repository.fetchFilters(ctg, topFinGrpNo, baseYear);
  }
}

@riverpod
class DialogFiltersViewModel extends _$DialogFiltersViewModel {
  @override
  AsyncValue<Map<String, List<(String, bool)>>> build(ProductCategory ctg){
    final currentSaved = ref.watch(savedFiltersProvider(ctg));
    return AsyncValue.data(Map<String, List<(String, bool)>>.from(currentSaved.value ?? {})); 
  }

  Future<void> toggleSelected(
    ProductCategory ctg,
    String text,
    bool selected,
  ) async {
    final currentState = state.value ?? {};
    final updated = {
      for (final entry in currentState.entries)
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

    final selectedFinGrp = updated["금융회사"];
    if (selectedFinGrp == null || selectedFinGrp == currentState["금융회사"]) {
      state = AsyncValue.data(updated);
      return;
    }
    final sFinGrpName =
        selectedFinGrp.where((e) => e.$2).map((e) => e.$1).firstOrNull ?? "";
    final topFinGrpNo = getFinGroupCode[sFinGrpName] ?? "020000";
    try {
      final cmpyList = await repository.fetchCmpyNames(topFinGrpNo);
      state = AsyncValue.data({
        for (final entry in updated.entries)
          if (entry.key == "회사 선택")
            entry.key: cmpyList
                .map<(String, bool)>((e) => (e as String, false))
                .toList()
          else
            entry.key: entry.value,
      });
      debugPrint("filter: toggle state, $state");
    } catch (error) {
      debugPrint("Failed to fetch company list, $error");
      state = AsyncValue.data(updated);
    }
  }

  void selectBaseYear(String year) {
    try {
      final currentState = state.value ?? {};

      final updated = {
        for (final entry in currentState.entries)
          if (entry.key == "기준년도")
            entry.key: [(year, true)]
          else
            entry.key: entry.value,
      };
      state = AsyncValue.data(updated);
    } catch (e) {
      debugPrint("Failed to change the base year, $e");
      state = AsyncValue.data({});
    }
  }

  Future<void> applyChanges(String pageNo) async {
    final snapshot = Map<String, List<(String, bool)>>.from(state.value ?? {});
    ref.read(savedFiltersProvider(ctg).notifier).save(snapshot);

    if (snapshot["금융회사"] != null) {
      final topFinGrpName = snapshot["금융회사"]!
          .firstWhere((e) => e.$2 == true)
          .$1;
      final topFinGrpNo = getFinGroupCode[topFinGrpName] ?? "020000";
      ref
          .read(selectedTopFinGrpNoViewmodelProvider.notifier)
          .changeTopFinGrp(ctg, topFinGrpNo);
    }
    if (snapshot["기준년도"] != null) {
      final baseYear = snapshot["기준년도"]!.firstWhere((e) => e.$2 == true).$1;
      ref
          .read(selectedBaseYearViewmodelProvider.notifier)
          .changeBaseYear(ctg, int.tryParse(baseYear) ?? DateTime.now().year);
    }

    switch (ctg) {
      case ProductCategory.isaJoin:
        ref.read(fetchIsaJoinStatusViewmodelProvider(pageNo));
      case ProductCategory.isaManagement:
        ref.read(fetchIsaMngmStatusViewmodelProvider(pageNo));
      default:
        ref.read(fetchProductViewmodelProvider(ctg, pageNo));
    }
  }

  void resetChanges() async {
    final filters = ref.read(savedFiltersProvider(ctg)).value ?? {};
    state = AsyncValue.data(filters);
  }
}

@Riverpod(keepAlive: true)
@riverpod
class SavedFilters extends _$SavedFilters {
  @override
  Future<Map<String, List<(String, bool)>>> build(ProductCategory ctg) async{
    try {
      final data = await ref.read(filtersViewmodelProvider(ctg).future);
      return data;
    } catch (error) {
      debugPrint("error: Failed to fetch filters, $error");
      return {};
    }
  }

  void save(Map<String, List<(String, bool)>> filters) => state = AsyncValue.data(filters);
}
