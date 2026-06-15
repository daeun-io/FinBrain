import 'package:finbrain/data/repository/filters_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'filters_viewmodel.g.dart';

final repository = FiltersRepository();

@riverpod
class FiltersViewmodel extends _$FiltersViewmodel {
  @override
  Future<Map<String, List<(String, bool)>>> build() async {
    return await repository.fetchFilters();
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
  Map<String, List<(String, bool)>> build() {
    final filters = ref.watch(filtersViewmodelProvider);
    return filters.value ?? {};
  }

  void toggleSelected(String text, bool selected) {
    state = {
      for (final entry in state.entries)
        if (entry.value.contains((text, selected)))
          entry.key: entry.value.map((e) {
            if (entry.key == "금융 회사") {
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
