import 'package:finbrain/data/google_auth_service.dart';
import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/data/repository/ai_comp_repository.dart';
import 'package:finbrain/data/repository/ai_summary_repository.dart';
import 'package:finbrain/product_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'archive_viewmodel.g.dart';

// AI 대화 요약 내역 관련 레포지토리(AI summary repository)
final summaryRepository = AiSummaryRepository();
// AI 비교 분석 관련 레포지토리(AI comparison text repository)
final compRepository = AiCompRepository();

// AI 요약 필터링 뷰모델
// AI sumamries filter
@riverpod
class SelectedCtgForSummariesViewmodel
    extends _$SelectedCtgForSummariesViewmodel {
  // 초기값: 정기예금, 적금, ISA, 주택담보대출, 전세자금대출, 개인신용대출
  // Initial value: savings, ISA and loan
  @override
  List<ProductCategory> build() => [
    ProductCategory.deposit,
    ProductCategory.installment,
    ProductCategory.isaMp,
    ProductCategory.mortgage,
    ProductCategory.rent,
    ProductCategory.credit,
  ];

  // 필터링 리스트에 카테고리 추가
  // Add category in filter list
  void addCtg(ProductCategory ctg) {
    state = [...state, ctg];
  }

  // 필터링 리스트에 카테고리 제거
  // Delete category in filter list
  void deleteCtg(ProductCategory ctg) {
    state = state.where((e) => e != ctg).toList();
  }
}

// AI 요약 호출 뷰모델
// Fethcing AI sumamries viewmodel
@riverpod
class AiSummariesViewmodel extends _$AiSummariesViewmodel {
  // 서버에 저장된 AI 요약 불러오기
  // Fetch summaries in firestore
  @override
  Future<List<AiRecord>> build() async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        throw Exception("[user] no user found");
      }
      final summaries = await summaryRepository.getAllSummaries(user.uid);
      // 고정 여부에 따라 정렬(고정된 상품이 상단)
      // Display pinned products at the top
      summaries.sort(
        (a, b) => (b.isPinned ? 1 : -1).compareTo(a.isPinned ? 1 : -1),
      );
      return summaries;
    } catch (e) {
      throw Exception("[error] failed to fetch summaries : $e");
    }
  }
}

// 요약 아카이브 스크린 뷰모델
// Archive summary screen viewmodel
@riverpod
class ArchiveSummaryViewmodel extends _$ArchiveSummaryViewmodel {
  // 요약 필터와 요약 호출 뷰모델을 관찰해 화면에 디스플레이
  // Display summaries by watching filter and summaries viewmodel
  @override
  AsyncValue<List<AiRecord>> build() {
    final filter = ref.watch(selectedCtgForSummariesViewmodelProvider);
    final records = ref.watch(aiSummariesViewmodelProvider);
    return records.whenData(
      (data) => data.where((e) => filter.contains(e.category)).toList(),
    );
  }

  // 고정하기
  // Pin summary
  Future<void> pinRecord(AiRecord record) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        throw Exception("[user] no user found");
      }

      // 서버에 상태 업데이트
      // Update pin state in firestore
      await summaryRepository.updateSummaries(
        user.uid,
        record.key,
        record.value,
        record.category,
        record.name,
        !record.isPinned,
      );

      ref.invalidate(aiSummariesViewmodelProvider);

      // 데이터 재호출 후 로컬에 업데이트
      // Fetch renewal data and update in local 
      final allComparison = await ref.read(aiSummariesViewmodelProvider.future);
      final filter = ref.read(selectedCtgForSummariesViewmodelProvider);
      state = AsyncData(
        allComparison.where((e) => filter.contains(e.category)).toList(),
      );
    } catch (e) {
      throw Exception("[error] failed to pin summary : $e");
    }
  }

  // 리스트 타일 펼치기
  // Expand list tile
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

// AI 비교 분석 필터링 뷰모델
// AI comparison filter
@riverpod
class SelectedCtgForCompTextViewmodel
    extends _$SelectedCtgForCompTextViewmodel {
  // 초기값: 정기예금, 적금, ISA, 주택담보대출, 전세자금대출, 개인신용대출
  // Initial value: savings, ISA and loan
  @override
  List<ProductCategory> build() => [
    ProductCategory.deposit,
    ProductCategory.installment,
    ProductCategory.isaMp,
    ProductCategory.mortgage,
    ProductCategory.rent,
    ProductCategory.credit,
  ];

  // 필터링 리스트에 카테고리 추가
  // Add category in filter list
  void addCtg(ProductCategory ctg) {
    state = [...state, ctg];
  }

  // 필터링 리스트에 카테고리 제거
  // Delete category in filter list
  void deleteCtg(ProductCategory ctg) {
    state = state.where((e) => e != ctg).toList();
  }
}

// AI 비교 분석 호출 뷰모델
// Fethcing AI comparison texts viewmodel
@riverpod
class AiCompViewmodel extends _$AiCompViewmodel {
  // 서버에 저장된 AI 비교 분석 불러오기
  // Fetch comparison texts in firestore
  @override
  Future<List<AiRecord>> build() async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        throw Exception("[user] no user found");
      }
      final comparison = await compRepository.getComparisonTexts(user.uid);
      // 고정 여부에 따라 정렬(고정된 상품이 상단)
      // Display pinned products at the top
      comparison.sort(
        (a, b) => (b.isPinned ? 1 : -1).compareTo(a.isPinned ? 1 : -1),
      );
      return comparison;
    } catch (e) {
      throw Exception("[error] failed to fetch comparison texts : $e");
    }
  }
}

// 비교 분석 아카이브 스크린 뷰모델
// Archive comparison texts screen viewmodel
@riverpod
class ArchiveComparisonViewmodel extends _$ArchiveComparisonViewmodel {
  // 비교 분석 필터와 호출 뷰모델을 관찰해 화면에 디스플레이
  // Display comparison texts by watching filter and comparison text viewmodel
  @override
  AsyncValue<List<AiRecord>> build() {
    final filter = ref.watch(selectedCtgForCompTextViewmodelProvider);
    final records = ref.watch(aiCompViewmodelProvider);

    return records.whenData(
      (data) => data.where((e) => filter.contains(e.category)).toList(),
    );
  }

  // 고정하기
  // Pin text
  Future<void> pinRecord(AiRecord record) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        throw Exception("[user] no user found");
      }

      // 서버에 상태 업데이트
      // Update pin state in firestore
      await compRepository.saveComparisonText(
        user.uid,
        record.key,
        record.value.first.text,
        record.category,
        record.name,
        !record.isPinned,
      );

      ref.invalidate(aiCompViewmodelProvider);

      // 데이터 재호출 후 로컬에 업데이트
      // Fetch renewal data and update in local 
      final allComparison = await ref.read(aiCompViewmodelProvider.future);
      final filter = ref.read(selectedCtgForCompTextViewmodelProvider);
      state = AsyncData(
        allComparison.where((e) => filter.contains(e.category)).toList(),
      );
    } catch (e) {
      throw Exception("[error] failed to pin comparison text : $e");
    }
  }

  // 리스트 타일 펼치기
  // Expand list tile
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
