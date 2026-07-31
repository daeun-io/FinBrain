import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'shared_preferences_viewmodel.g.dart';

// 기기에서 앱 최초 실행 여부
// Check this app is ran on device for the first time
@riverpod
class SharedPreferencesViewmodel extends _$SharedPreferencesViewmodel {
  @override
  Future<bool> build() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isFirstRun = prefs.getBool("isFirstRun") ?? true;
    return isFirstRun;
  }

  // 확인 이후 최초 실행 여부 false로 전환
  // Set isFirstRun to false
  Future<void> setIsFirstRunToFalse() async {
    final currentValue = state.value ?? false;
    if (currentValue) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isFirstRun", false);
    }
    state = AsyncValue.data(false);
  }
}
