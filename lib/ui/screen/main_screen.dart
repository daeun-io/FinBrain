import 'package:finbrain/ui/screen/loan_screen.dart';
import 'package:finbrain/ui/screen/savings_screen.dart';
import 'package:finbrain/ui/screen/liked_screen.dart';
import 'package:finbrain/ui/tutorial_helper.dart';
import 'package:finbrain/ui/viewmodel/text_theme_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/ai_comp_tutorial_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({
    super.key,
    this.index,
    this.isAiCompTutorial,
    this.isIsaTutorial,
  });

  final int? index;
  final bool? isAiCompTutorial;
  final bool? isIsaTutorial;

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  late int _currentIndex;
  late Set<int> _visitedIndices;

  // 튜토리얼을 위한 변수
  // Variables for tutorial
  final List<TargetFocus> targets = [];
  GlobalKey aiCompKey1 = GlobalKey();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index ?? 0;

    // 방문한 탭(캐시 유지)
    // visited indicies to retain cache
    _visitedIndices = {_currentIndex};

    // 튜토리얼 띄우기
    // Launch tutorial
    ref.read(aiCompTutorialViewmodelProvider.future).then((value) {
      if (value == false) {
        _showAiCompTutorial();
      }
    });
  }

  void _showAiCompTutorial() {
    initTarget(
      context,
      targets,
      aiCompKey1,
      ContentAlign.top,
      ShapeLightFocus.Circle,
      "관심 상품을 확인하세요\n하단 메뉴에서 관심 설정한 금융 상품을 한 눈에 볼 수 있습니다",
      "AI 비교 분석애 관한 설명을 듣고 싶다면 해당 버튼을 클릭해 튜토리얼을 진행하세요",
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        Duration(
          milliseconds:
              (widget.isAiCompTutorial == true || widget.isIsaTutorial == true)
              ? 300
              : 3000,
        ),
        () => showTutorial(context, targets),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: const CustomAppbar(screen: "main", title: "핀브레인"),
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _visitedIndices.contains(0)
              ? SavingsScreen(isIsaTutorial: widget.isIsaTutorial)
              : const SizedBox.shrink(),
          _visitedIndices.contains(1)
              ? const LoanScreen()
              : const SizedBox.shrink(),
          _visitedIndices.contains(2)
              ? LikedScreen(isAiCompTutorial: widget.isAiCompTutorial)
              : const SizedBox.shrink(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: colorScheme.secondary,
            border: Border(
              top: BorderSide(color: colorScheme.outline, width: 1.0),
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory,
              highlightColor: colorScheme.onSurface,
            ),
            child: BottomNavigationBar(
              onTap: (value) {
                setState(() {
                  _currentIndex = value;
                  // 방문한 탭 추가(add visited incides)
                  _visitedIndices.add(value);
                });
              },
              currentIndex: _currentIndex,
              elevation: 0,
              enableFeedback: false,
              backgroundColor: Colors.transparent,
              selectedItemColor: colorScheme.onPrimary,
              unselectedItemColor: colorScheme.onTertiary,
              selectedLabelStyle: textTheme.labelLarge,
              unselectedLabelStyle: textTheme.labelMedium,
              type: BottomNavigationBarType.fixed,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.savings, size: 28),
                  label: "예적금",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.paid, size: 28),
                  label: "대출",
                ),
                BottomNavigationBarItem(
                  key: aiCompKey1,
                  icon: Icon(Icons.favorite, size: 28),
                  label: "관심",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
