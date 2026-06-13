import 'package:finbrain/data/dummy_filters.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'filters_provider.g.dart';

@riverpod
class FiltersNotifier extends _$FiltersNotifier {
  @override
  Map<String, List<(String, bool)>> build() {
    return dummyFilters;
  }

  void saveChanges(Map<String, List<(String, bool)>> newFilters) {
    state = newFilters;
  }
}

@riverpod
class DialogFilterNotifier extends _$DialogFilterNotifier {
  @override
  Map<String, List<(String, bool)>> build() {
    final filters = ref.watch(filtersNotifierProvider);
    return filters;
  }

  void toggleSelected(String text, bool selected) {
    state = {
      for (final entry in state.entries)
        if (entry.value.contains((text, selected)))
          entry.key: entry.value.map((e) {
            if(entry.key == "금융 회사"){
              return e.$1 == text ? (e.$1, true) : (e.$1, false);
            }
            return e.$1 == text ? (e.$1, !selected) : e;
          }).toList()
        else
          entry.key: entry.value,
    };
  }
  
  void resetChanges(){
    state = ref.read(filtersNotifierProvider);
  }
}
