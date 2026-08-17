import 'package:finbrain/ui/screen/loan_screen.dart';
import 'package:finbrain/ui/screen/savings_screen.dart';
import 'package:finbrain/ui/screen/liked_screen.dart';
import 'package:finbrain/ui/viewmodel/text_theme_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key, this.index});

  final int? index;
  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  late int _currentIndex;
  late Set<int> _visitedIndices;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index ?? 0;

    // 방문한 탭(캐시 유지)
    // visited indicies to retain cache
    _visitedIndices = {_currentIndex};
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
              ? const SavingsScreen()
              : const SizedBox.shrink(),
          _visitedIndices.contains(1)
              ? const LoanScreen()
              : const SizedBox.shrink(),
          _visitedIndices.contains(2)
              ? const LikedScreen()
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
                const BottomNavigationBarItem(
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
