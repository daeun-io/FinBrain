import 'package:finbrain/ui/viewmodel/isa_guide_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/text_theme_viewmodel.dart';
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

  // ISA 제도 Q&A 사이트로 이동
  // Move to ISA Q&A website
  void launchIsaUrl(TextStyle style) {
    final colorScheme = Theme.of(context).colorScheme;
    ref.read(isaGuideScreenViewmodelProvider.notifier).openISAQandAUrl().then((
      isSuccess,
    ) {
      if (!isSuccess) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: colorScheme.scrim,
            duration: Duration(seconds: 3),
            content: Text(
              "오류: 외부 url으로의 이동이 실패했습니다, 다시 시도해주세요",
              style: style.copyWith(color: colorScheme.onSecondary),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            Expanded(
              child: PageView(
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
                  guideImage("${path}_05.svg", 5),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SmoothPageIndicator(
              controller: _pageController,
              count: 5, // Number of pages
              effect: ScrollingDotsEffect(
                spacing: 12.0,
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: colorScheme.onTertiaryFixed,
                dotColor: colorScheme.scrim,
              ),
            ),
            const SizedBox(height: 16),
            if (_currentPage == 0)
              GestureDetector(
                onTap: () {
                  launchIsaUrl(textTheme.bodySmall!);
                },
                behavior: HitTestBehavior.opaque,
                child: button("ISA 제도 Q&A 바로가기", textTheme.titleMedium!),
              ),
            // 마지막 페이지면 이동 버튼 디스플레이
            // Display navigation button when last page
            if (_currentPage == 4)
              GestureDetector(
                onTap: () async {
                  if (context.mounted) {
                    Navigator.of(context).pop(true);
                  }
                  await ref
                      .read(isaGuideViewmodelProvider.notifier)
                      .setDisplayedIsaGuideToTrue();
                },
                behavior: HitTestBehavior.opaque,
                child: button("시작하기", textTheme.titleMedium!),
              ),
            const SizedBox(height: 40),
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

  Widget button(String title, TextStyle style) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: colorScheme.outline),
      ),
      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 32.0),
      child: Center(
        child: Text(title, style: style.copyWith(color: colorScheme.onPrimary)),
      ),
    );
  }
}
