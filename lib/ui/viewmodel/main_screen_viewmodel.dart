import 'package:finbrain/data/data_source/user_data_source.dart';
import 'package:finbrain/data/google_auth_service.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'main_screen_viewmodel.g.dart';

@riverpod
class MainScreenViewmodel extends _$MainScreenViewmodel{
  final userDataSource = UserDataSource();

  @override
  bool build() => false;

  Future<void> setUserOptions() async{
    final user = GoogleAuthService.getCurrentUser();

    try {
      if(user != null){
        await userDataSource.setUserOptions(user);
        await Future.delayed(Duration(seconds: 1));
      } else {
        debugPrint("[error] user doesn't exist");
      }
    } catch(e){
      debugPrint("[error] failed to set user options, $e");
    }
  }
}