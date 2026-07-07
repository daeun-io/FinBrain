import 'dart:async';

import 'package:finbrain/data/converter.dart';
import 'package:finbrain/data/repository/filters_repository.dart';
import 'package:finbrain/ui/viewmodel/isa_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/selected_topFinGrpNo_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'filters_viewmodel.g.dart';

final repository = FiltersRepository();

@riverpod
class FiltersViewmodel extends _$FiltersViewmodel {
  @override
  Future<Map<String, List<(String, bool)>>> build(ProductCategory ctg) async {
    final topFinGrpMap = ref.watch(selectedTopfingrpnoViewmodelProvider);
    print("topFinGrp by selected topFingrp viewmodel: $topFinGrpMap");
    final topFinGrpNo =
        topFinGrpMap[switch (ctg) {
          ProductCategory.deposit || ProductCategory.installment => "예적금",
          ProductCategory.mortgage ||
          ProductCategory.rent ||
          ProductCategory.credit => "대출",
          ProductCategory.annuity => "연금저축",
          _ => "",
        }] ??
        "020000";
    return await repository.fetchFilters(ctg, topFinGrpNo);
  }
}

@riverpod
class DialogFiltersViewModel extends _$DialogFiltersViewModel {
  @override
  Map<String, List<(String, bool)>> build(ProductCategory ctg) {
    final currentSaved = ref.read(savedFiltersProvider(ctg));
    if (currentSaved.isEmpty) {
      fetchInitialFilters(ctg);
      return {};
    }
    return Map<String, List<(String, bool)>>.from(currentSaved);
  }

  Future<void> fetchInitialFilters(ProductCategory ctg) async {
    try {
      final data = await ref.read(filtersViewmodelProvider(ctg).future);
      if (data.isNotEmpty) {
        state = Map<String, List<(String, bool)>>.from(data);
      }
    } catch (error) {
      debugPrint("error: Failed to fetch filters, $error");
    }
  }

  Future<void> toggleSelected(
    ProductCategory ctg,
    String text,
    bool selected,
  ) async {
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
      debugPrint("filter: toggle state, $state");
    } catch (error) {
      debugPrint("Failed to fetch company list, $error");
      state = updated;
    }
  }

  void selectBaseYear(String year) {
    try {
      final updated = {
        for (final entry in state.entries)
          if (entry.key == "기준년도")
            entry.key: [(year, true)]
          else
            entry.key: entry.value,
      };
      state = updated;
    } catch (e) {
      debugPrint("Failed to change the base year, $e");
      state = {};
    }
  }

  Future<void> applyChanges(String pageNo) async {
    final snapshot = Map<String, List<(String, bool)>>.from(state);
    ref.read(savedFiltersProvider(ctg).notifier).save(snapshot);
    if (snapshot["금융회사"] != null) {
      final topFinGrpName = snapshot["금융회사"]!
          .firstWhere((e) => e.$2 == true)
          .$1;
      final topFinGrpNo =
          getFinGroupCode[topFinGrpName] ??
          ((ctg == ProductCategory.annuity) ? "050000" : "020000");
      ref.read(selectedTopfingrpnoViewmodelProvider.notifier).changeTopFinGrp(
        switch (ctg) {
          ProductCategory.deposit || ProductCategory.installment => "예적금",
          ProductCategory.mortgage ||
          ProductCategory.rent ||
          ProductCategory.credit => "대출",
          ProductCategory.annuity => "연금저축",
          _ => "",
        },
        topFinGrpNo,
      );
    }

    switch (ctg) {
      case ProductCategory.isaJoin:
        ref
            .read(isaJoinStatusViewModelProvider.notifier)
            .fetchIsaJoinStatus(pageNo, snapshot);
      case ProductCategory.isaManagement:
        ref
            .read(isaManagementStatusViewModelProvider.notifier)
            .fetchIsaManagementStatus(pageNo, snapshot);
      case ProductCategory.isaMp:
        ref
            .read(productViewmodelProvider.notifier)
            .fetchIsaMpProducts(pageNo, snapshot);
      default:
        ref
            .read(productViewmodelProvider.notifier)
            .fetchFinlifeProducts(ctg, "1", snapshot);
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
  Map<String, List<(String, bool)>> build(ProductCategory ctg) => {};

  void save(Map<String, List<(String, bool)>> filters) => state = filters;
}
