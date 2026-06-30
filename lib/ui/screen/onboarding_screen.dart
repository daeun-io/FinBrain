import 'package:finbrain/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:finbrain/ui/screen/main_screen.dart';
import 'package:finbrain/data/google_auth_repository.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
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
            effect: const ScrollingDotsEffect(
              spacing: 12.0,
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: primary400,
              dotColor: Color(0xffD9D9D9),
            ),
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () => _signInWithGoogle(context),
            child: Image.asset(
              'assets/images/signin_neutral.png',
              width: MediaQuery.of(context).size.width * 0.65,
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  void _signInWithGoogle(BuildContext context) async {
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
