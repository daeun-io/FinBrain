import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finbrain/data/dummy_filters.dart';
import 'package:flutter_riverpod/legacy.dart';

class FiltersNotifier extends StateNotifier<Map<String, List<(String, bool)>>> {
  FiltersNotifier() : super(dummyFilters);

  void toggleSelected(String text, bool selected) {
    state = {
      for (final entry in state.entries)
        if (entry.value.contains((text, selected)))
          entry.key: entry.value.map((e){
            return e.$1 == text ? (e.$1, !selected) : e;
          }).toList()
        else
          entry.key: entry.value,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<String, List<(String, bool)>>>((
      ref,
    ) {
      return FiltersNotifier();
    });

final selectedFilterProvider = Provider<List<(String, bool)>>((ref) {
  final List<(String, bool)> selectedFilters = [];
  final allFilters = ref.watch(filtersProvider);

  for (var pair in allFilters.values.expand((e) => e).toList()) {
    if (pair.$2) {
      selectedFilters.add(pair);
    }
  }
  return selectedFilters;
});
