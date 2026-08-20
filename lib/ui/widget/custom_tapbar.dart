import 'package:finbrain/ui/tutorial_helper.dart';
import 'package:finbrain/ui/viewmodel/isa_viewmodel.dart';
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
  ConsumerState<CustomTapbar> createState() => CustomTapbarState();
}

class CustomTapbarState extends ConsumerState<CustomTapbar> {
  // 튜토리얼을 위한 변수
  // Variables for tutorial
  final List<TargetFocus> targets = [];
  List<GlobalKey> tutorialKeys = [GlobalKey(), GlobalKey(), GlobalKey()];
  
  @override
  void initState(){
    super.initState();

    ref.read(isaTutorialViemodelProvider.future).then((value){
      if(value == false && widget.isIsaScreen){
        _showIsaTutorial();
      }
    });

  }

  // 튜토리얼 설정 및 보이기
  // Set and show isa tutorial
  void _showIsaTutorial(){
    initTarget(
      context,
      targets,
      tutorialKeys[0],
      ContentAlign.bottom,
      ShapeLightFocus.Circle,
      "ISA(Individual Savings Account)\n가입자가 예적금 펀드 등 다양한 금융상품을 선택해 포트폴리오를 구성하고 통합 관리할 수 있는 계좌, 개인이 직접 구성, 운용하는 펀드와 유사",
      "가입 현황 자료를 통해 업권 및 계좌 유형별 가입자 수 및 회사 수를 통해 타 가입자들의 선택 및 선호도를 파악할 수 있습니다.",
    );
    initTarget(
      context,
      targets,
      tutorialKeys[1],
      ContentAlign.bottom,
      ShapeLightFocus.Circle,
      "운용 현황 자료를 통해 업권 및 계좌 유형별 자산이 어떻게 배분돼 운용되는지 그 금액과 비중을 확인할 수 있습니다.",
    );
    initTarget(
      context,
      targets,
      tutorialKeys[2],
      ContentAlign.bottom,
      ShapeLightFocus.Circle,
      "MP 수익률에서는 일임형 상품별 MP 운용 수익률을 제공해 운용 성과 비교가 가능합니다.\n\n기타 카테고리와 같이 AI 도우미를 통해 상품에 대한 정보를 쉽게 얻을 수 있습니다",
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        Duration(milliseconds: 300),
        () => showTutorial(
          context,
          targets,
          () => ref
              .read(isaTutorialViemodelProvider.notifier)
              .setReadIsaTutorialToTrue(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

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
            key: tutorialKeys[i],
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
