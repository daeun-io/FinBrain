import 'package:finbrain/data/dummy_filters.dart';

class FiltersRepository {
  Future<Map<String, List<(String, bool)>>> fetchFilters() async {
    return dummyFilters;
  }

  Future<Map<String, List<(String, bool)>>> saveChanges(
    Map<String, List<(String, bool)>> newFilters,
  ) async => newFilters;
  
}
