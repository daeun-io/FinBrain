import 'package:finbrain/ui/viewmodel/shared_preferences_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ISA 설명 스크린
// ISA explanation screen
class IsaGuideScreen extends ConsumerStatefulWidget {
  const IsaGuideScreen({super.key});

  @override
  ConsumerState<IsaGuideScreen> createState() => _IsaGuideScreenState();
}

class _IsaGuideScreenState extends ConsumerState<IsaGuideScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
      path = "assets/images/isa_guide_light_portrait";
    } else if ((!isTablet || isPortrait) && !isLightMode) {
      path = "assets/images/isa_guide_dark_portrait";
    } else if (!isPortrait && isLightMode) {
      path = "assets/images/isa_guide_light_landscape";
    } else {
      path = "assets/images/isa_guide_dark_landscape";
    }

    return SafeArea(
      child: Container(
        color: colorScheme.primary,
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _currentPage = value;
                });
              },
              children: [
                guideImage("${path}_01.svg", 1),
                guideImage("${path}_02.svg", 2),
                guideImage("${path}_03.svg", 3),
                guideImage("${path}_04.svg", 4),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SmoothPageIndicator(
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
              ),
            ),
            // 마지막 페이지면 이동 버튼 디스플레이
            // Display navigation button when last page
            if (_currentPage == 3)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: GestureDetector(
                    onTap: () async {
                      await ref
                          .read(sharedPreferencesViewmodelProvider.notifier)
                          .setIsFirstRunToFalse();
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 14.0,
                        horizontal: 32.0,
                      ),
                      child: Text(
                        "시작하기",
                        style: textTheme.headlineLarge!.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget guideImage(String path, int num) {
    return SvgPicture.asset(
      path,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.8,
      fit: BoxFit.contain,
      alignment: Alignment.topCenter,
      semanticsLabel: "Isa guide screen $num",
    );
  }
}
