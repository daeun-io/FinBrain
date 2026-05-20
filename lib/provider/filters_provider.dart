import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finbrain/data/dummy_filters.dart';

final filtersProvider = Provider<Map<String, List<(String, bool)>>>((ref){
  return dummyFilters;
});