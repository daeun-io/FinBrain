import 'package:finbrain/data/fin_group_code.dart';
import 'package:finbrain/data/repository/filters_repository.dart';
import 'package:finbrain/data/viewModel/selected_topFinGrpNo_viewmodel.dart';
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
    final topFinGrpNo = topFinGrpMap[switch(ctg){
      FilterTextCategory.savings => "예적금",
      FilterTextCategory.loan => "대출",
      FilterTextCategory.annuity => "연금저축",
      _ => ""
    }] ?? "020000";
    return await repository.fetchFilters(ctg, topFinGrpNo);
  }

  Future<void> saveChanges(Map<String, List<(String, bool)>> newFilters) async {
    state = await AsyncValue.guard(() async {
      return await repository.saveChanges(newFilters);
    });
  }
}

@riverpod
class DialogFiltersViewModel extends _$DialogFiltersViewModel {
  @override
  Map<String, List<(String, bool)>> build(
    FilterTextCategory ctg,
  ) {
    final filters = ref.watch(filtersViewmodelProvider(ctg));
    return filters.value ?? {};
  }

  void toggleSelected(String text, bool selected) {
    state = {
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
  }

  void resetChanges() => state = state;
}
