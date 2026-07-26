import 'package:finbrain/ui/screen/loan_screen.dart';
import 'package:finbrain/ui/screen/savings_screen.dart';
import 'package:finbrain/ui/viewmodel/current_ctg_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/current_page_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/ui/screen/liked_screen.dart';
import 'package:finbrain/ui/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // 바텀 네비게이션 뷰(bottom navigation view)
    final bottomView = const [SavingsScreen(), LoanScreen(), LikedScreen()];

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: const CustomAppbar(screen: "main", title: "FinBrain")
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: bottomView,
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
                // 바텀 네비게이션에 따라 데이터 불러오기
                // Fetch data based on bottom navigation
                setState(() {
                  _currentIndex = value;
                });
                final ctg = ref.read(currentCtgViewmodelProvider);
                final page = ref.read(currentPageViewmodelProvider(ctg));
                ref.read(fetchProductViewmodelProvider(ctg, "$page"));
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
