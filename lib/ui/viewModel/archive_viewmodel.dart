import 'package:finbrain/data/google_auth_service.dart';
import 'package:finbrain/data/converter.dart';
import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/data/repository/ai_comp_repository.dart';
import 'package:finbrain/data/repository/ai_summary_repository.dart';
import 'package:finbrain/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'archive_viewmodel.g.dart';

@riverpod
class ArchiveSummaryViewmodel extends _$ArchiveSummaryViewmodel {
  final repository = AiSummaryRepository();

  @override
  Future<List<AiRecord>> build() async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        print("No current user found");
        return <AiRecord>[];
      }
      final summaries = await repository.getAllSummaries(user.uid);
      summaries.sort((a, b) => b.isPinned ? 1 : -1);
      return summaries;
    } catch (e) {
      print("Error occured in building vm, $e");
      return <AiRecord>[];
    }
  }

  void pinRecord(AiRecord record) {
    state = AsyncData(
      (state.value ?? []).map((e) {
        if (e.key == record.key) {
          return e.copyWith(null, !e.isPinned);
        } else {
          return e;
        }
      }).toList(),
    );
  }

  void expandRecord(AiRecord record) {
    state = AsyncData(
      (state.value ?? []).map((e) {
        if (e.key == record.key) {
          return e.copyWith(!e.isExpanded);
        } else {
          return e;
        }
      }).toList(),
    );
  }
}

@riverpod
class SelectedCtgForArchiveViewmodel extends _$SelectedCtgForArchiveViewmodel {
  @override
  List<ProductCategory> build() => ProductCategory.values;

  void addCtg(ProductCategory ctg) {
    state = [...state, ctg];
  }

  void deleteCtg(ProductCategory ctg) {
    state = state.where((e) => e != ctg).toList();
  }
}

@riverpod
class AiCompViewmodel extends _$AiCompViewmodel {
  final repository = AiCompRepository();

  @override
  Future<List<AiRecord>> build() async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        print("No current user found");
        return <AiRecord>[];
      }
      final summaries = await repository.getComparisonTexts(user.uid);
      summaries.sort((a, b) => b.isPinned ? 1 : -1);
      return summaries;
    } catch (e) {
      print("Error occured in building vm, $e");
      return <AiRecord>[];
    }
  }
}

@riverpod
class ArchiveComparisonViewmodel extends _$ArchiveComparisonViewmodel {
  final repository = AiCompRepository();

  @override
  AsyncValue<List<AiRecord>> build(){
    final filter = ref.watch(selectedCtgForArchiveViewmodelProvider);
    final records = ref.watch(aiCompViewmodelProvider);

    return records.whenData((data) => data.where((e) => filter.contains(e.category)).toList());
  }

  void pinRecord(AiRecord record) {
    state = AsyncData(
      (state.value ?? []).map((e) {
        if (e.key == record.key) {
          return e.copyWith(null, !e.isPinned);
        } else {
          return e;
        }
      }).toList(),
    );
  }

  void expandRecord(AiRecord record) {
    state = AsyncData(
      (state.value ?? []).map((e) {
        if (e.key == record.key) {
          return e.copyWith(!e.isExpanded);
        } else {
          return e;
        }
      }).toList(),
    );
  }
}
