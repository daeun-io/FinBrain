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

// 카테고리에 따른 기본 필터 불러오는 뷰모델
// Fetch default filter viewmodel by category
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

// 다이얼로그에 보이는 필터
// Filter shown in dialog
@riverpod
class DialogFiltersViewModel extends _$DialogFiltersViewModel {
  @override
  AsyncValue<Map<String, List<(String, bool)>>> build(ProductCategory ctg){
    final currentSaved = ref.watch(savedFiltersProvider(ctg));
    return AsyncValue.data(Map<String, List<(String, bool)>>.from(currentSaved.value ?? {})); 
  }

  // 필터 칩 선택/미선택 변경
  // Change whether chip is selected/unselected
  Future<void> toggleSelected(
    ProductCategory ctg,
    String text,
    bool selected,
  ) async {
    final currentState = state.value ?? {};
    // 기본 필터 칩 업데이트
    // Basic filter chip update
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
    
    // 업권 필터 변경
    // Change company category
    final selectedFinGrp = updated["금융회사"];
    // 선택 카테고리가 없으면 이 외 것만 반영
    // Update basic filters if there is no company category 
    if (selectedFinGrp == null || selectedFinGrp == currentState["금융회사"]) {
      state = AsyncValue.data(updated);
      return;
    }
    final sFinGrpName =
        selectedFinGrp.where((e) => e.$2).map((e) => e.$1).firstOrNull ?? "";
    final topFinGrpNo = getFinGroupCode[sFinGrpName] ?? "020000";
    try {
      // 선택한 업권에 따라 회사 목록 불러오고 회사 선택 초기화
      // Fetch company list based on its category and initialize
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
    } catch (e) {
      debugPrint("[error] failed to fetch companies, $e");
      state = AsyncValue.data(updated);
    }
  }

  // ISA: 기준 년도 선택
  // ISA: Select base year
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
      debugPrint("[error] failed to change base year, $e");
      state = AsyncValue.data({});
    }
  }

  // 선택한 필터 항목 저장
  // Save selected filter options
  Future<void> applyChanges(String pageNo) async {
    final snapshot = Map<String, List<(String, bool)>>.from(state.value ?? {});
    ref.read(savedFiltersProvider(ctg).notifier).save(snapshot);

    // 기준년도 및 회사 업권 뷰모델 업데이트
    // Update base year and company category
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

    // 업데이트된 필터 기반으로 데이터 불러오기
    // Fetch data based on updated filter
    switch (ctg) {
      case ProductCategory.isaJoin:
        ref.read(fetchIsaJoinStatusViewmodelProvider(pageNo));
      case ProductCategory.isaManagement:
        ref.read(fetchIsaMngmStatusViewmodelProvider(pageNo));
      default:
        ref.read(fetchProductViewmodelProvider(ctg, pageNo));
    }
  }

  // 선택 초기화
  // Reset Changes
  void resetChanges() async {
    final filters = ref.read(savedFiltersProvider(ctg)).value ?? {};
    state = AsyncValue.data(filters);
  }
}

// 상품 카테고리별 필터
// Filter by product category
@Riverpod(keepAlive: true)
@riverpod
class SavedFilters extends _$SavedFilters {
  // 생성 시 카테고리 별 기본 필터 호출
  // Fetch default filter by given category
  @override
  Future<Map<String, List<(String, bool)>>> build(ProductCategory ctg) async{
    try {
      final data = await ref.read(filtersViewmodelProvider(ctg).future);
      return data;
    } catch (e) {
      throw Exception("[error] failed to fetch $ctg filters, $e");
    }
  }

  // 변경사항 저장
  // Save filter change
  void save(Map<String, List<(String, bool)>> filters) => state = AsyncValue.data(filters);
}
