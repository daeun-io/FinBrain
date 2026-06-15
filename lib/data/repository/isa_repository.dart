import 'package:finbrain/data/isa_dummy.dart';
import 'package:finbrain/data/model/entities/isa_join_status.dart';
import 'package:finbrain/data/model/entities/isa_management_status.dart';

class IsaRepository {
  Future<List<IsaJoinStatus>> fetchJoinStatus() async{
    return isaJoinDummy;
  }

  Future<List<IsaManagementStatus>> fetchManagementStatus() async{
    return isaManagementDummy;
  }
}