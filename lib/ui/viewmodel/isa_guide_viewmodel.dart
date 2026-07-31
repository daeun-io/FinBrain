import 'package:finbrain/data/api_constants.dart';
import 'package:finbrain/data/data_source/user_data_source.dart';
import 'package:finbrain/data/google_auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';
part 'isa_guide_viewmodel.g.dart';

// ISA 가이드 스크린 디스플레이 한 적있는지 확인
// Check if ISA guide was shown before
@riverpod
class IsaGuideViewmodel extends _$IsaGuideViewmodel{
  final dataSource = UserDataSource();

  // ISA 가이드를 보였는지 여부 확인
  // Check if isa guide was displayed before
  @override
  Future<bool> build() async {
    final user = GoogleAuthService.getCurrentUser();
    if(user == null || user.email == null || user.displayName == null) return true;
    return await dataSource.displayedIsaGuideBefore(user);
  }

  // displayed_isa_guide를 true로 업데이트
  // Update displayed_isa_guide to true
  Future<void> setDisplayedIsaGuideToTrue() async {
    await dataSource.setDisplayedIsaGuideToTrue();
  }
}

@riverpod
class IsaGuideScreenViewmodel extends _$IsaGuideScreenViewmodel{
  @override
  bool build() => false;

  // ISA 제도 Q&A 사이트로 이동
  // Move to ISA Q&A website
  Future<bool> openISAQandAUrl() async {
    try {
      final url = Uri.parse(isaQandA);
      await launchUrl(url, mode: LaunchMode.externalApplication);
      return true;
    } catch (error) {
      return false;
    }
  }
}