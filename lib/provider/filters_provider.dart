import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finbrain/data/dummy_filters.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'filters_provider.g.dart';

@riverpod
class FiltersNotifier extends _$FiltersNotifier{
  @override
  Map<String, List<(String, bool,)>> build(){
    return dummyFilters;
  }

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

final selectedFilterProvider = Provider<List<(String, bool)>>((ref) {
  final List<(String, bool)> selectedFilters = [];
  final allFilters = ref.watch(filtersNotifierProvider);

  for (var pair in allFilters.values.expand((e) => e).toList()) {
    if (pair.$2) {
      selectedFilters.add(pair);
    }
  }
  return selectedFilters;
});
