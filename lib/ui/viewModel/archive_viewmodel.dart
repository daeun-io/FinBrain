import 'package:finbrain/data/google_auth_service.dart';
import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/data/repository/ai_comp_repository.dart';
import 'package:finbrain/data/repository/ai_summary_repository.dart';
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
class ArchiveComparisonViewmodel extends _$ArchiveComparisonViewmodel {
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
