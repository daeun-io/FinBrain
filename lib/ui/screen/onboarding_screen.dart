import 'package:finbrain/ui/screen/policy_screen.dart';
import 'package:finbrain/ui/viewmodel/onboarding_screen_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/text_theme_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:finbrain/ui/screen/main_screen.dart';
import 'package:finbrain/data/google_auth_service.dart';

class OnBoardingScreen extends ConsumerWidget {
  OnBoardingScreen({super.key});

  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);
    // 모드 및 기기에 따라 동적으로 이미지 불러오기
    // Fetch image dynamically based on mode and device
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    String path = "";
    if ((!isTablet || isPortrait) && isLightMode) {
      path = "assets/images/onboarding/light_portrait";
    } else if ((!isTablet || isPortrait) && !isLightMode) {
      path = "assets/images/onboarding/dark_portrait";
    } else if (!isPortrait && isLightMode) {
      path = "assets/images/onboarding/light_landscape";
    } else {
      path = "assets/images/onboarding/dark_landscape";
    }

    // 구글 로그인하기(google social login)
    void _signInWithGoogle(BuildContext context, WidgetRef ref) async {
      if (!context.mounted) return;
      final userCredential = await GoogleAuthService().signInWithGoogle();

      if (userCredential == null) {
        if (context.mounted) {
          CustomSnackBar.show(context, ref, text: "로그인에 실패했습니다. 다시 시도해주세요");
        }
      } else {
        final user = userCredential.user;
        if (user == null) return;
        // 첫 로그인 여부 확인
        // Check if this is the first login
        final isFirstLogin = await ref.read(
          onboardingScreenViewmodelProvider(user).future,
        );

        if (isFirstLogin == null) {
          if (context.mounted) {
            CustomSnackBar.show(context, ref, text: "로그인에 실패했습니다. 다시 시도해주세요");
          }
          // 첫 로그인이면
        } else if (isFirstLogin) {
          if (context.mounted) {
            // 동의 여부 확인
            // Check if user agreed to the the policy
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => PolicyScreen(isAgreed: false),
              ),
            );
          }
        } else {
          if (context.mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => MainScreen()),
            );
          }
        }
      }
    }

    return SafeArea(
      child: Container(
        color: colorScheme.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  OnBoardingImage(context, "${path}_01.svg", 1),
                  OnBoardingImage(context, "${path}_02.svg", 2),
                  OnBoardingImage(context, "${path}_03.svg", 3),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SmoothPageIndicator(
              controller: _pageController,
              count: 3, // Number of pages
              effect: ScrollingDotsEffect(
                spacing: 12.0,
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: colorScheme.onTertiaryFixed,
                dotColor: colorScheme.scrim,
              ),
            ),
            const SizedBox(height: 28),
            GestureDetector(
              onTap: () {
                _signInWithGoogle(context, ref);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: colorScheme.secondary,
                  border: Border.all(color: colorScheme.outline, width: 1),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
                child: Text(
                  "핀브레인 시작하기",
                  style: textTheme.headlineLarge!.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget OnBoardingImage(BuildContext context, String path, int num) {
    return SvgPicture.asset(
      path,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.8,
      fit: BoxFit.contain,
      alignment: Alignment.topCenter,
      semanticsLabel: "Onboarding illustration $num",
    );
  }
}
