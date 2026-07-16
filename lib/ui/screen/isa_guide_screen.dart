import 'package:finbrain/ui/viewmodel/shared_preferences_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
    final isLightMode = Theme.of(context).brightness == Brightness.light;

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
                SvgPicture.asset(
                  (isLightMode)
                      ? "assets/images/isa_guide_light_01.svg"
                      : "assets/images/isa_guide_dark_01.svg",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.8,
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                  semanticsLabel: "Onboading illustration 01",
                ),
                SvgPicture.asset(
                  (isLightMode)
                      ? "assets/images/isa_guide_light_02.svg"
                      : "assets/images/isa_guide_dark_02.svg",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.8,
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                  semanticsLabel: "Onboading illustration 02",
                ),
                SvgPicture.asset(
                  (isLightMode)
                      ? "assets/images/isa_guide_light_03.svg"
                      : "assets/images/isa_guide_dark_03.svg",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.8,
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                  semanticsLabel: "Onboading illustration 03",
                ),
                SvgPicture.asset(
                  (isLightMode)
                      ? "assets/images/isa_guide_light_04.svg"
                      : "assets/images/isa_guide_dark_04.svg",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.8,
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                  semanticsLabel: "Onboading illustration 04",
                ),
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
                      if(context.mounted){
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
}
