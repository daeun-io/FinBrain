import 'package:finbrain/data/data_source/user_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'onboarding_screen_viewmodel.g.dart';

@riverpod
class OnboardingScreenViewmodel extends _$OnboardingScreenViewmodel {
  final userDataSource = UserDataSource();

  // 첫 로그인인지 확인
  // Check if this is the first login
  @override
  Future<bool?> build(User? user) {
    return userDataSource.isFirstLogin(user);
  }

  // 이메일과 이름 서버에 저장
  // Save email and name to the server
  Future<void> saveEmailAndDisplayName(User? user) async {
    debugPrint("유저, $user");
    if (user == null || user.email == null || user.displayName == null) return;
    await userDataSource.saveEmailAndDisplayName(user);
  }
}
