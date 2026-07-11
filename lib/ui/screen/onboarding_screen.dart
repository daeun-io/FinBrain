import 'package:flutter/material.dart';
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

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // todo: add onboarding images later
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                Container(
                  color: Colors.blue,
                  child: const Center(
                    child: Text(
                      'Welcome to the FinBrain!',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  color: Colors.green,
                  child: const Center(
                    child: Text(
                      'Discover new features.',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  color: Colors.orange,
                  child: const Center(
                    child: Text(
                      'Get Started Now!',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 40),
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
                style: textTheme.headlineLarge!.copyWith(color: colorScheme.onPrimary),
              ),
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  void _signInWithGoogle(BuildContext context) async {
    if (!context.mounted) return;

    final userCredential = await GoogleAuthService().signInWithGoogle();

    if (userCredential == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('로그인에 실패했습니다. 다시 시도해주세요')));
    } else {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (ctx) => MainScreen()));
    }
  }
}
