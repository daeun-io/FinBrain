import 'package:finbrain/data/google_auth_service.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/themes/text_theme.dart';
import 'package:finbrain/ui/screen/archive_screen.dart';
import 'package:finbrain/ui/screen/main_screen.dart';
import 'package:finbrain/ui/screen/onboarding_screen.dart';
import 'package:finbrain/ui/screen/product_detail_screen.dart';
import 'package:finbrain/ui/viewmodel/ai_comp_tutorial_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/my_page_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/privacy_policy_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/text_theme_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_appbar.dart';
import 'package:finbrain/ui/widget/markdown_text_render.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);
    final user = GoogleAuthService.getCurrentUser();

    void _navigateToOnboarding(BuildContext context) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => OnBoardingScreen()),
        (route) => false,
      );
    }

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(screen: "my_page", title: "마이페이지"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 36,
            left: 20,
            right: 20,
            bottom: 36,
          ),
          child: Column(
            children: [
              // 프로필(profile)
              Row(
                children: [
                  Icon(
                    Icons.account_circle,
                    color: colorScheme.surfaceContainerHighest,
                    size: 50,
                  ),
                  const SizedBox(width: 5.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (user != null && user.displayName != null)
                              ? user.displayName!
                              : "성이름",
                          style: textTheme.bodyLarge!.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          (user != null && user.email != null)
                              ? user.email!
                              : "이메일 주소",
                          style: textTheme.bodyMedium!.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // 기록 보관소 이동 버튼
                      // Button for navigating to archive
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => ArchiveScreen()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                colorScheme.surfaceContainerLowest,
                                colorScheme.surfaceContainerLow,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 22,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.archive,
                                color: colorScheme.surfaceContainerHighest,
                                size: 24,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "기록 보관소로 이동",
                                style: textTheme.titleMedium!.copyWith(
                                  color: colorScheme.onSecondary,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: colorScheme.onSecondary,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // 글자 모드 변경 버튼
                      // Change text theme button
                      Container(
                        color: colorScheme.primary,
                        padding: const EdgeInsets.only(left: 8.0, right: 1.0),
                        child: Row(
                          children: [
                            Icon(Icons.text_increase, size: 24.0),
                            const SizedBox(width: 8.0),
                            Text(
                              "큰 글씨 모드",
                              style: textTheme.bodyMedium!.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            ),
                            const Spacer(),
                            Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                value: (textTheme == bigTextTheme),
                                onChanged: (value) {
                                  ref
                                      .read(textThemeViewmodelProvider.notifier)
                                      .changeTxtTheme();
                                },
                                activeColor: colorScheme.surfaceContainerHighest,
                                inactiveThumbColor: colorScheme.tertiary,
                                inactiveTrackColor: colorScheme.onTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      // 개인정보처리방침(privacy policies)
                      MyPageButton(
                        context,
                        ref,
                        () async {
                          // 개인정보 처리 방침 읽고 디스플레이
                          // Read and display privacy policy
                          final policy = await ref.read(
                            privacyPolicyViewmodelProvider.future,
                          );
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: colorScheme.surfaceContainer,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return Container(
                                height: MediaQuery.of(context).size.height * 0.8,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 32,
                                  horizontal: 20,
                                ),
                                child: MarkdownTextRenderer(str: policy),
                              );
                            },
                          );
                        },
                        Icon(
                          Icons.policy_outlined,
                          color: colorScheme.onSecondary,
                          size: 22,
                        ),
                        "개인정보 처리방침",
                      ),
                      const SizedBox(height: 16),
                      // 앱 이용 안내(튜토리얼)
                      // app manual(tutorial)
                      ExpansionTile(
                        leading: Icon(
                          Icons.book_outlined,
                          color: colorScheme.onSecondary,
                          size: 20,
                        ),
                        title: Text(
                          "앱 이용 안내",
                          style: textTheme.bodyMedium!.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                        backgroundColor: colorScheme.secondary,
                        collapsedBackgroundColor: colorScheme.secondary,
                        iconColor: colorScheme.onSecondary,
                        collapsedIconColor: colorScheme.onSecondary,
                        shape: const Border(),
                        children: [
                          TutorialTextBtn(context, ref, "상세 화면 및 AI 채팅"),
                          TutorialTextBtn(context, ref, "ISA"),
                          TutorialTextBtn(context, ref, "AI 비교 분석"),
                          const SizedBox(height: 4.0),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // 문의(inquiry)
                      MyPageButton(
                        context,
                        ref,
                        () {
                          ref.read(myPageViewmodelProvider.notifier).openMail();
                        },
                        Icon(
                          Icons.contact_support_outlined,
                          color: colorScheme.onSecondary,
                          size: 22,
                        ),
                        "문의하기",
                      ),
                      const SizedBox(height: 16),
                      // 로그아웃(logout)
                      MyPageButton(
                        context,
                        ref,
                        () {
                          GoogleAuthService.signOut();
                          _navigateToOnboarding(context);
                        },
                        Icon(
                          Icons.logout,
                          color: colorScheme.onSecondary,
                          size: 20,
                        ),
                        "로그아웃",
                      ),
                      const SizedBox(height: 40),
                      // 탈퇴하기(delete account)
                      MyPageButton(
                        context,
                        ref,
                        () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: colorScheme.surfaceContainer,
                                contentPadding: const EdgeInsets.all(20.0),
                                content: SizedBox(
                                  width: 300,
                                  height: 206,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "정말 서비스에서",
                                        style: textTheme.headlineSmall!.copyWith(
                                          color: colorScheme.onSecondary,
                                        ),
                                      ),
                                      Text(
                                        "탈퇴하시겠습니까?",
                                        style: textTheme.headlineSmall!.copyWith(
                                          color: colorScheme.onSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        "기존에 작성한 모든 기록이 삭제됩니다",
                                        style: textTheme.bodyMedium!.copyWith(
                                          color: colorScheme.onSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 32),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: TextButton(
                                              onPressed: () {
                                                _navigateToOnboarding(context);
                                                ref
                                                    .read(
                                                      myPageViewmodelProvider
                                                          .notifier,
                                                    )
                                                    .deleteAllDataOfUser();
                                              },
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    colorScheme.onPrimaryFixed,
                                                shadowColor: colorScheme.surface,
                                              ),
                                              child: Text(
                                                "예",
                                                style: textTheme.bodyLarge!
                                                    .copyWith(
                                                      color:
                                                          colorScheme.onSurface,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    colorScheme.secondary,
                                                shadowColor: colorScheme.surface,
                                                side: BorderSide(
                                                  color: colorScheme
                                                      .outline, // Change your border color here
                                                  width:
                                                      1.0, // Change border thickness
                                                ),
                                              ),
                                              child: Text(
                                                "아니오",
                                                style: textTheme.bodyLarge!
                                                    .copyWith(
                                                      color:
                                                          colorScheme.onSecondary,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        Icon(
                          Icons.person_off_outlined,
                          color: colorScheme.onPrimaryFixed,
                          size: 20,
                        ),
                        "탈퇴하기",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 기타 버튼(other button)
  ListTile MyPageButton(
    BuildContext context,
    WidgetRef ref,
    void Function() onTap,
    Icon leadingIcon,
    String title,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return ListTile(
      onTap: onTap,
      leading: leadingIcon,
      title: Text(
        title,
        style: (title == "탈퇴하기")
            ? textTheme.titleMedium!.copyWith(color: colorScheme.onPrimaryFixed)
            : textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      tileColor: colorScheme.secondary,
    );
  }

  // 튜토리얼 텍스트 버튼
  Widget TutorialTextBtn(BuildContext context, WidgetRef ref, String text) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return GestureDetector(
      onTap: () {
        if (text == "AI 비교 분석") {
          ref
              .read(aiCompTutorialViewmodelProvider.notifier)
              .setReadAiCompTutorialToValue(false);
          // 변경된 상태를 반영하기 위해 invalidate
          // Invalidate provider to apply changed state
          ref.invalidate(aiCompTutorialViewmodelProvider);
        }
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) {
              switch (text) {
                case "상세 화면 및 AI 채팅":
                  return const ProductDetailScreen(
                    productCode: "tutorial",
                    productName: "우리웰리치 주거래예금",
                    category: ProductCategory.deposit,
                    fromLikedScreen: false,
                    isTutorial: true,
                  );
                case "ISA":
                  return const MainScreen(isIsaTutorial: true);
                default:
                  return const MainScreen(isAiCompTutorial: true);
              }
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            text,
            style: textTheme.titleMedium!.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
