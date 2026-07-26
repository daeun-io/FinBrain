import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:finbrain/ui/screen/main_screen.dart';
import 'package:finbrain/data/google_auth_service.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    // 모드 및 기기에 따라 동적으로 이미지 불러오기
    // Fetch image dynamically based on mode and device
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    String path = "";
    if ((!isTablet || isPortrait) && isLightMode) {
      path = "assets/images/onboarding_light_portrait";
    } else if ((!isTablet || isPortrait) && !isLightMode) {
      path = "assets/images/onboarding_dark_portrait";
    } else if (!isPortrait && isLightMode) {
      path = "assets/images/onboarding_light_landscape";
    } else {
      path = "assets/images/onboarding_dark_landscape";
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
                  onBoardingImage(context, "${path}_01.svg", 1),
                  onBoardingImage(context, "${path}_02.svg", 2),
                  onBoardingImage(context, "${path}_03.svg", 3),
                  onBoardingImage(context, "${path}_04.svg", 4),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SmoothPageIndicator(
              controller: _pageController,
              count: 4, // Number of pages
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
                _signInWithGoogle(context);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  border: Border.all(color: colorScheme.onPrimary, width: 1),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 32.0),
                child: Text(
                  "FINBRAIN 시작하기",
                  style: textTheme.headlineLarge!.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget onBoardingImage(BuildContext context, String path, int num) {
    return SvgPicture.asset(
      path,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.8,
      fit: BoxFit.contain,
      alignment: Alignment.topCenter,
      semanticsLabel: "Onboarding illustration $num",
    );
  }

  // 구글 로그인하기(google social login)
  void _signInWithGoogle(BuildContext context) async {
    if (!context.mounted) return;

    final userCredential = await GoogleAuthService().signInWithGoogle();

    if (userCredential == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('로그인에 실패했습니다. 다시 시도해주세요')));
      }
    } else {
      if (context.mounted) {
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (ctx) => MainScreen()));
      }
    }
  }
}
