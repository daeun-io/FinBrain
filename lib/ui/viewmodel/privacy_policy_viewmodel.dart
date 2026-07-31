import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'privacy_policy_viewmodel.g.dart';

@riverpod
class PrivacyPolicyViewmodel extends _$PrivacyPolicyViewmodel{
  // 개인정보 처리방침 불러오기
  // Fetch privacy policy
  @override
  Future<String> build() async{
    return await rootBundle.loadString('assets/privacy_policy.md');
  }
}