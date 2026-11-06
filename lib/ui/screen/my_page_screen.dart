import 'package:finbrain/data/google_auth_service.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/themes/text_theme.dart';
import 'package:finbrain/ui/screen/archive_screen.dart';
import 'package:finbrain/ui/screen/main_screen.dart';
import 'package:finbrain/ui/screen/my_page_detail_screen.dart';
import 'package:finbrain/ui/screen/onboarding_screen.dart';
import 'package:finbrain/ui/screen/product_detail_screen.dart';
import 'package:finbrain/ui/viewmodel/ai_comp_tutorial_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/my_page_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/privacy_policy_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/text_theme_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_text.dart';
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

    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 36,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 프로필(profile)
                    CustomText(
                      text: "안녕하세요\n${user?.displayName}님",
                      style: textTheme.displayLarge!.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomText(
                      text: user?.email ?? "이메일 로딩에 실패했습니다",
                      style: textTheme.bodyMedium!.copyWith(
                        color: colorScheme.onTertiary,
                      ),
                    ),
                    const SizedBox(height: 48),
                    // 마이페이지 아이콘 버튼
                    Row(
                      children: [
                        Expanded(
                          child: MyPageIconButton(
                            context,
                            ref,
                            () {
                              ref
                                  .read(myPageViewmodelProvider.notifier)
                                  .openMail();
                            },
                            Icons.email_outlined,
                            "문의하기",
                          ),
                        ),
                        Expanded(
                          child: MyPageIconButton(
                            context,
                            ref,
                            () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => const ArchiveScreen(),
                                ),
                              );
                            },
                            Icons.archive_outlined,
                            "기록 저장소",
                          ),
                        ),
                        Expanded(
                          child: MyPageIconButton(
                            context,
                            ref,
                            () {
                              // 추후 구현
                            },
                            Icons.campaign_outlined,
                            "공지사항",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48.0),
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
                              activeTrackColor:
                                  colorScheme.surfaceContainerHighest,
                              thumbColor: colorScheme.tertiary,
                              inactiveThumbColor: colorScheme.tertiary,
                              inactiveTrackColor: colorScheme.onTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    MyPageListTile(
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
                      Icons.policy_outlined,
                      "개인정보 처리방침",
                    ),
                    const SizedBox(height: 16),
                    MyPageListTile(
                      context,
                      ref,
                      () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) =>
                                MyPageDetailScreen(title: "앱 튜토리얼 다시보기"),
                          ),
                        );
                      },
                      Icons.book_outlined,
                      "앱 튜토리얼 다시보기",
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyPageTextButton(
                            () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        colorScheme.surfaceContainer,
                                    contentPadding: const EdgeInsets.all(20.0),
                                    content: SizedBox(
                                      width: 300,
                                      height: 206,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "정말 서비스에서",
                                            style: textTheme.headlineSmall!
                                                .copyWith(
                                                  color:
                                                      colorScheme.onSecondary,
                                                ),
                                          ),
                                          Text(
                                            "탈퇴하시겠습니까?",
                                            style: textTheme.headlineSmall!
                                                .copyWith(
                                                  color:
                                                      colorScheme.onSecondary,
                                                ),
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            "기존에 작성한 모든 기록이 삭제됩니다.",
                                            style: textTheme.bodyMedium!
                                                .copyWith(
                                                  color:
                                                      colorScheme.onSecondary,
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
                                                    _navigateToOnboarding(
                                                      context,
                                                    );
                                                    ref
                                                        .read(
                                                          myPageViewmodelProvider
                                                              .notifier,
                                                        )
                                                        .deleteAllDataOfUser();
                                                  },
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: colorScheme
                                                        .onPrimaryFixed,
                                                    shadowColor:
                                                        colorScheme.surface,
                                                  ),
                                                  child: Text(
                                                    "예",
                                                    style: textTheme.bodyLarge!
                                                        .copyWith(
                                                          color: colorScheme
                                                              .onSurface,
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
                                                    shadowColor:
                                                        colorScheme.surface,
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
                                                          color: colorScheme
                                                              .onSecondary,
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
                            Icons.person_off_outlined,
                            "탈퇴하기",
                            colorScheme.error,
                            textTheme.bodyMedium!,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyPageTextButton(
                            () {
                              GoogleAuthService.signOut();
                              _navigateToOnboarding(context);
                            },
                            Icons.logout_outlined,
                            "로그아웃",
                            colorScheme.onSecondary,
                            textTheme.bodyMedium!,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyPageIconButton(
    BuildContext context,
    WidgetRef ref,
    void Function() onTap,
    IconData icon,
    String text,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: colorScheme.onSecondary, size: 40),
          CustomText(
            text: text,
            style: textTheme.bodyMedium!.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget MyPageTextButton(
    void Function() onTap,
    IconData icon,
    String text,
    Color color,
    TextStyle style,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 4),
          CustomText(
            text: text,
            style: style.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  ListTile MyPageListTile(
    BuildContext context,
    WidgetRef ref,
    void Function() onTap,
    IconData leadingIcon,
    String title,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return ListTile(
      onTap: onTap,
      leading: Icon(leadingIcon, color: colorScheme.onSecondary, size: 22),
      title: Text(
        title,
        style: textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      tileColor: colorScheme.secondary,
    );
  }

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
