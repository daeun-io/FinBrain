import 'package:finbrain/data/model/entities/isa_join_status.dart';
import 'package:finbrain/data/model/entities/isa_management_status.dart';
import 'package:finbrain/data/repository/isa_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'isa_viewmodel.g.dart';

final repository = IsaRepository();

@riverpod
class IsaJoinStatusViewModel extends _$IsaJoinStatusViewModel{
  Future<List<IsaJoinStatus>> build() async{
    return await repository.fetchJoinStatus();
  }
}

@riverpod
class IsaManagementStatusViewModel extends _$IsaManagementStatusViewModel{
  Future<List<IsaManagementStatus>> build() async{
    return await repository.fetchManagementStatus();
  }
}