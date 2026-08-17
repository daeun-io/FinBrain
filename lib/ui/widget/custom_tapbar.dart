import 'package:finbrain/ui/viewmodel/text_theme_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class CustomTapbar extends ConsumerStatefulWidget {
  const CustomTapbar({
    super.key,
    required this.tabList,
    required this.isIsaScreen,
    this.onTapFunc,
    this.controller,
  });

  final List<String> tabList; // 탭 리스트
  final bool isIsaScreen; // ISA 스크린 여부
  final Function(int)? onTapFunc; // 탭 시 실행할 함수
  final TabController? controller; // 컨트롤러

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomTapbarState();
}

class _CustomTapbarState extends ConsumerState<CustomTapbar> {
  // 튜토리얼을 위한 변수
  // Variables for tutorial
  final List<TargetFocus> targets = [];
  List<GlobalKey> keys = [GlobalKey(), GlobalKey(), GlobalKey()];
  bool isIsaTutorialShown = false;

  // 튜토리얼 추가하는 함수
  // Add tutorial target
  void initTarget(GlobalKey key, String content, [String? content2]) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    targets.add(
      TargetFocus(
        identify: key,
        keyTarget: key,
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: (content2 == null)
                ? Container(
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: colorScheme.secondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Text(
                      content,
                      style: textTheme.bodyMedium!.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: colorScheme.secondary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Text(
                          content,
                          style: textTheme.bodyMedium!.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: colorScheme.secondary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Text(
                          content2,
                          style: textTheme.bodyMedium!.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  // 튜토리얼 보이기
  void showTutorial() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    TutorialCoachMark(
      targets: targets,
      textSkip: "건너뛰기",
      textStyleSkip: textTheme.bodySmall!.copyWith(
        color: colorScheme.onSurface,
      ),
      pulseEnable: false,
    ).show(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    if (widget.isIsaScreen && !isIsaTutorialShown) {
      isIsaTutorialShown = true;
      initTarget(
        keys[0], 
        "ISA(Individual Savings Account)\n가입자가 예적금 펀드 등 다양한 금융상품을 선택해 포트폴리오를 구성하고 통합 관리할 수 있는 계좌, 개인이 직접 구성, 운용하는 펀드와 유사", 
        "가입 현황 자료를 통해 업권 및 계좌 유형별 가입자 수 및 회사 수를 통해 타 가입자들의 선택 및 선호도를 파악할 수 있습니다.");
      initTarget(
        keys[1],
        "운용 현황 자료를 통해 업권 및 계좌 유형별 자산이 어떻게 배분돼 운용되는지 그 금액과 비중을 확인할 수 있습니다.",
      );
      initTarget(
        keys[2],
        "MP 수익률에서는 일임형 상품별 MP 운용 수익률를 제공해 운용 성과 비교가 가능합니다.\n\n기타 카테고리와 같이 AI 도우미를 통해 상품에 대한 정보를 쉽게 얻을 수 있습니다",
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration(milliseconds: 300), () => showTutorial());
      });
    }

    // ISA 스크린여부에 따라 디자인 변경
    // Change design whether it is called from ISA screen or not
    return TabBar(
      onTap: widget.onTapFunc,
      controller: widget.controller,
      indicator: (widget.isIsaScreen)
          ? BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: colorScheme.surfaceContainerHigh,
            )
          : UnderlineTabIndicator(
              borderSide: BorderSide(color: colorScheme.onPrimary, width: 2.0),
            ),
      labelColor: (widget.isIsaScreen)
          ? colorScheme.onSurface
          : colorScheme.onPrimary,
      unselectedLabelColor: colorScheme.onTertiary,
      dividerColor: (widget.isIsaScreen)
          ? colorScheme.surface
          : colorScheme.onTertiary,
      labelStyle: textTheme.titleMedium,
      unselectedLabelStyle: textTheme.bodyMedium,
      indicatorSize: TabBarIndicatorSize.tab,
      splashFactory: NoSplash.splashFactory,
      tabs: [
        for (int i = 0; i < widget.tabList.length; i++)
          Container(
            key: keys[i],
            alignment: Alignment.center,
            height: (widget.isIsaScreen) ? 40 : 60,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(widget.tabList[i]),
            ),
          ),
      ],
    );
  }
}
