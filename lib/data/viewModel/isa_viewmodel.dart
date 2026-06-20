import 'package:finbrain/data/models/entities/isa_join_status.dart';
import 'package:finbrain/data/models/entities/isa_management_status.dart';
import 'package:finbrain/data/repository/isa_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'isa_viewmodel.g.dart';

final repository = IsaRepository();

@riverpod
class IsaJoinStatusViewModel extends _$IsaJoinStatusViewModel {
  @override
  Future<List<IsaJoinStatus>> build(
    String pageNo,
    String numOfRows,
    String baseYearMonth,
    String domain,
    String isaForm,
  ) async {
    return await repository.fetchJoinStatus(
      pageNo,
      numOfRows,
      baseYearMonth,
      domain,
      isaForm,
    );
  }

  void sortByCriteria(String criteria) {
    final isaJoinData = state.valueOrNull ?? [];
    state = AsyncData(
      isaJoinData..sort(switch (criteria) {
        "회사 수(오름차순)" => (a, b) => a.companyCount!.compareTo(b.companyCount!),
        "회사 수(내림차순)" => (b, a) => b.companyCount!.compareTo(a.companyCount!),
        "가입자 수(오름차순)" => (a, b) => a.joinMemberCount!.compareTo(
          b.joinMemberCount!,
        ),
        _ => (a, b) => b.joinMemberCount!.compareTo(a.joinMemberCount!),
      }),
    );
  }
}

@riverpod
class IsaManagementStatusViewModel extends _$IsaManagementStatusViewModel {
  @override
  Future<List<IsaManagementStatus>> build(
    String pageNo,
    String numOfRows,
    String baseYearMonth,
    String ctg,
    String domain,
    String isaForm,
  ) async {
    return await repository.fetchManagementStatus(
      pageNo,
      numOfRows,
      baseYearMonth,
      ctg,
      domain,
      isaForm,
    );
  }

  void sortByCriteria(String criteria) {
    final isaMnData = state.valueOrNull ?? [];
    state = AsyncData(
      isaMnData..sort(
        (a, b) => (criteria == "금액/비율(오름차순)")
            ? a.amount!.compareTo(b.amount!)
            : b.amount!.compareTo(a.amount!),
      ),
    );
  }
}
