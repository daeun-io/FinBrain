import 'package:finbrain/data/models/entities/isa_join_status.dart';
import 'package:finbrain/data/models/entities/isa_management_status.dart';
import 'package:finbrain/data/repository/isa_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'isa_viewmodel.g.dart';

final repository = IsaRepository();

@riverpod
class IsaJoinStatusViewModel extends _$IsaJoinStatusViewModel {
  @override
  Future<(int, List<IsaJoinStatus>)> build() async {
    final status = await repository.fetchJoinStatus("1", "100", "2026", "", "");
    return status;
  }

  void fetchIsaJoinStatus(
    String pageNo,
    String numOfRows,
    String baseYearMonth,
    String domain,
    String isaForm,
  ) async {
    final joinStatus = await repository.fetchJoinStatus(
      pageNo,
      numOfRows,
      baseYearMonth,
      domain,
      isaForm,
    );
    state = AsyncData(joinStatus);
  }

  void sortByCriteria(String criteria, [List<IsaJoinStatus>? status]) {
    // final isaJoinData = status ?? ((state.value == null) ? [] : state.value!.$2);
    final currentState = state.valueOrNull ?? (0, <IsaJoinStatus>[]);
    final totalCount = currentState.$1;
    final isaJoinData = currentState.$2;

    state = AsyncData((
      totalCount,
      isaJoinData..sort(switch (criteria) {
        "회사 수(오름차순)" => (a, b) => a.companyCount!.compareTo(b.companyCount!),
        "회사 수(내림차순)" => (b, a) => b.companyCount!.compareTo(a.companyCount!),
        "가입자 수(오름차순)" => (a, b) => a.joinMemberCount!.compareTo(
          b.joinMemberCount!,
        ),
        _ => (a, b) => b.joinMemberCount!.compareTo(a.joinMemberCount!),
      }),
    ));
  }
}

@riverpod
class IsaManagementStatusViewModel extends _$IsaManagementStatusViewModel {
  @override
  Future<(int, List<IsaManagementStatus>)> build() async{
    final status = await repository.fetchManagementStatus("1", "100", "2026", "비중", "", "");
    return status;
  }

  void fetchIsaManagementStatus(
    String pageNo,
    String numOfRows,
    String baseYearMonth,
    String ctg,
    String domain,
    String isaForm,
  ) async {
    final mngmStatus = await repository.fetchManagementStatus(
      pageNo,
      numOfRows,
      baseYearMonth,
      ctg,
      domain,
      isaForm,
    );
    state = AsyncData(mngmStatus);
  }

  void sortByCriteria(String criteria) {
    final currentState = state.valueOrNull ?? (0, <IsaManagementStatus>[]);
    final totalCount = currentState.$1;
    final isaMnData = currentState.$2;

    state = AsyncData((
      totalCount,
      isaMnData..sort(
        (a, b) => (criteria == "금액/비율(오름차순)")
            ? a.amount!.compareTo(b.amount!)
            : b.amount!.compareTo(a.amount!),
      ),
    ));
  }
}
