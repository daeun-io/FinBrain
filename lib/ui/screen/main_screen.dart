import 'package:finbrain/themes/text_theme.dart';
import 'package:finbrain/ui/screen/archive_screen.dart';
import 'package:finbrain/ui/screen/loan_screen.dart';
import 'package:finbrain/ui/screen/savings_screen.dart';
import 'package:finbrain/ui/viewModel/current_ctg_viewmodel.dart';
import 'package:finbrain/ui/viewModel/current_page_viewmodel.dart';
import 'package:finbrain/ui/viewModel/product_viewmodel.dart';
import 'package:finbrain/ui/viewModel/text_theme_viewmodel.dart';
import 'package:finbrain/ui/screen/liked_screen.dart';
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
    final currTxtTheme = ref.watch(textThemeViewmodelProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: AppBar(
            backgroundColor: colorScheme.primary,
            scrolledUnderElevation: 0.0,
            // change later
            leading: Image.asset("assets/images/app_icon.png"),
            title: Text(
              "FinBrain",
              style: textTheme.headlineMedium!.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w900,
              ),
            ),
            titleSpacing: -8,
            actions: [
              OutlinedButton(
                onPressed: () {
                  ref
                      .read(textThemeViewmodelProvider.notifier)
                      .changeTxtTheme(
                        (currTxtTheme == bigTextTheme) ? true : false,
                      );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 12.0,
                  ),
                  side: BorderSide(color: colorScheme.onPrimary, width: 1),
                ),
                // todo: implement later
                child: Text(
                  (currTxtTheme == bigTextTheme) ? "작은 글씨" : "큰 글씨",
                  style: textTheme.titleMedium!.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (ctx) => ArchiveScreen()));
                },
                icon: Icon(
                  Icons.archive_sharp,
                  color: colorScheme.surfaceContainerHighest,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [SavingsScreen(), LoanScreen(), LikedScreen()],
      ),
      bottomNavigationBar: Container(
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
            selectedLabelStyle: textTheme.titleMedium,
            unselectedLabelStyle: textTheme.bodyMedium,
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
    );
  }
}
