import 'package:finbrain/data/data_source/user_data_source.dart';
import 'package:finbrain/data/google_auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';
part 'my_page_viewmodel.g.dart';

@riverpod
class MyPageViewmodel extends _$MyPageViewmodel {
  final userDataStore = UserDataSource();

  @override
  bool build() => false;

  // 메일 열기
  Future<void> openMail() async {
    final Uri emailLaunchUri = Uri(
      scheme: "mailto",
      path: "dev.leedaeun@gmail.com",
    );

    try {
      bool isLaunched = await launchUrl(
        emailLaunchUri,
        mode: LaunchMode.externalApplication
      );

      if(!isLaunched){
        debugPrint("[error] failed to open mail app");
      }
    } catch(e){
      debugPrint("[error] failed to launch mail uri, $e");
    }
  }

  // 탈퇴 시 유저의 모든 데이터 삭제하기
  // Delete all data of user when deleting account
  Future<void> deleteAllDataOfUser() async{
    final user = GoogleAuthService.getCurrentUser();
    try {
      if(user != null){
        await userDataStore.deleteAllDataOfUser(user);
      } else {
        debugPrint("[error] user doesn't exist");
      }
    } catch (e){
      debugPrint("[error] failed to delete user data, $e");
    }
  }
}
