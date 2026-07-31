import 'package:finbrain/data/data_source/user_data_source.dart';
import 'package:finbrain/ui/viewmodel/shared_preferences_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'onboarding_screen_viewmodel.g.dart';

@riverpod
class OnboardingScreenViewmodel extends _$OnboardingScreenViewmodel{
  @override
  int build() => 0;
  
  // 서비스 시작 시 이메일과 이름 서버에 저장
  // Save email and name to the server at service start
  Future<void> saveEmailAndDisplayName(User? user) async {
    if(user == null) return;

    final dataSource = UserDataSource();
    final isFirstRun = await ref.read(sharedPreferencesViewmodelProvider.future);
    if(isFirstRun){
      await dataSource.saveEmailAndDisplayName(user);
    }
  }
}