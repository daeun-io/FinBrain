import 'package:finbrain/data/google_auth_service.dart';
import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/data/repository/ai_comp_repository.dart';
import 'package:finbrain/data/repository/ai_summary_repository.dart';
import 'package:finbrain/product_categories.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'archive_viewmodel.g.dart';

final summaryRepository = AiSummaryRepository();
final compRepository = AiCompRepository();

@riverpod
class SelectedCtgForSummariesViewmodel
    extends _$SelectedCtgForSummariesViewmodel {
  @override
  List<ProductCategory> build() => [
    ProductCategory.deposit,
    ProductCategory.installment,
    ProductCategory.isaMp,
    ProductCategory.mortgage,
    ProductCategory.rent,
    ProductCategory.credit,
  ];

  void addCtg(ProductCategory ctg) {
    state = [...state, ctg];
  }

  void deleteCtg(ProductCategory ctg) {
    state = state.where((e) => e != ctg).toList();
  }
}

@riverpod
class AiSummariesViewmodel extends _$AiSummariesViewmodel {
  @override
  Future<List<AiRecord>> build() async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        throw Exception("현재 로그인한 유저를 찾지 못했습니다");
      }
      final summaries = await summaryRepository.getAllSummaries(user.uid);
      summaries.sort(
        (a, b) => (b.isPinned ? 1 : -1).compareTo(a.isPinned ? 1 : -1),
      );
      return summaries;
    } catch (e) {
      throw Exception("AI 대화 요약 기록을 불러오는데 오류가 발생했습니다, $e");
    }
  }
}

@riverpod
class ArchiveSummaryViewmodel extends _$ArchiveSummaryViewmodel {
  @override
  AsyncValue<List<AiRecord>> build() {
    final filter = ref.watch(selectedCtgForSummariesViewmodelProvider);
    final records = ref.watch(aiSummariesViewmodelProvider);
    return records.whenData(
      (data) => data.where((e) => filter.contains(e.category)).toList(),
    );
  }

  Future<void> pinRecord(AiRecord record) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        debugPrint("No user is currently signed in.");
        return;
      }
      
      await summaryRepository.updateSummaries(
        user.uid,
        record.key,
        record.value,
        record.category,
        !record.isPinned,
      );

      ref.invalidate(aiSummariesViewmodelProvider);

      final allComparison = await ref.read(aiSummariesViewmodelProvider.future);
      final filter = ref.read(selectedCtgForSummariesViewmodelProvider);
      state = AsyncData(
        allComparison.where((e) => filter.contains(e.category)).toList(),
      );
    } catch (e) {
      print("Error checking collection existence: $e");
    }
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
class SelectedCtgForCompTextViewmodel
    extends _$SelectedCtgForCompTextViewmodel {
  @override
  List<ProductCategory> build() => [
    ProductCategory.deposit,
    ProductCategory.installment,
    ProductCategory.isaMp,
    ProductCategory.mortgage,
    ProductCategory.rent,
    ProductCategory.credit,
  ];

  void addCtg(ProductCategory ctg) {
    state = [...state, ctg];
  }

  void deleteCtg(ProductCategory ctg) {
    state = state.where((e) => e != ctg).toList();
  }
}

@riverpod
class AiCompViewmodel extends _$AiCompViewmodel {
  @override
  Future<List<AiRecord>> build() async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        throw Exception("현재 로그인한 유저를 찾지 못했습니다");
      }
      final comparison = await compRepository.getComparisonTexts(user.uid);
      comparison.sort(
        (a, b) => (b.isPinned ? 1 : -1).compareTo(a.isPinned ? 1 : -1),
      );
      return comparison;
    } catch (e) {
      throw Exception("AI 비교 분석 기록을 불러오는데 오류가 발생했습니다, $e");
    }
  }
}

@riverpod
class ArchiveComparisonViewmodel extends _$ArchiveComparisonViewmodel {
  @override
  AsyncValue<List<AiRecord>> build() {
    final filter = ref.watch(selectedCtgForCompTextViewmodelProvider);
    final records = ref.watch(aiCompViewmodelProvider);

    return records.whenData(
      (data) => data.where((e) => filter.contains(e.category)).toList(),
    );
  }

  Future<void> pinRecord(AiRecord record) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        debugPrint("No user is currently signed in.");
        return;
      }

      await compRepository.saveComparisonText(
        user.uid,
        record.key,
        record.value.first.text,
        record.category,
        !record.isPinned,
      );

      ref.invalidate(aiCompViewmodelProvider);

      final allComparison = await ref.read(aiCompViewmodelProvider.future);
      final filter = ref.read(selectedCtgForCompTextViewmodelProvider);
      state = AsyncData(
        allComparison.where((e) => filter.contains(e.category)).toList(),
      );
    } catch (e) {
      print("Error checking collection existence: $e");
    }
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
