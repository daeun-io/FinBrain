import 'package:finbrain/themes/text_style.dart';
import 'package:finbrain/ui/screen/archive_screen.dart';
import 'package:finbrain/ui/viewmodel/current_ctg_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/liked_screen.dart';
import 'package:finbrain/ui/screen/product_base_screen.dart';
import 'package:finbrain/ui/screen/product_screen.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData(ProductCategory.deposit);
    });
  }

  void loadData(ProductCategory ctg) {
    if (ctg != ProductCategory.isaJoin ||
        ctg != ProductCategory.isaManagement ||
        ctg != ProductCategory.isaJoin) {
      ref
          .read(productViewmodelProvider.notifier)
          .fetchFinlifeProducts(ctg, "1");
    }
  }

  ProductCategory _getCurrentCtgForIndex(int index, ProductCategory ctgInVM) {
    switch (index) {
      case 0:
        if (ctgInVM == ProductCategory.deposit ||
            ctgInVM == ProductCategory.installment ||
            ctgInVM == ProductCategory.isaJoin) {
          return ctgInVM;
        }
        return ProductCategory.deposit;
      case 1:
        if (ctgInVM == ProductCategory.mortgage ||
            ctgInVM == ProductCategory.rent ||
            ctgInVM == ProductCategory.credit) {
          return ctgInVM;
        }
        return ProductCategory.mortgage;
      case 2:
        return ProductCategory.annuity;
      default:
        return ctgInVM;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    ref.listen<ProductCategory>(currentCtgViewmodelProvider, (prev, next) {
      if (_currentIndex != 3) {
        loadData(next);
      }
    });

    final pages = [
      ProductScreen(category: ProductScreenCategory.savings),
      ProductScreen(category: ProductScreenCategory.loan),
      ProductBaseScreen(category: ProductCategory.annuity),
      const LikedScreen(),
    ];

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
              style: headingMd.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w900,
              ),
            ),
            titleSpacing: -8,
            actions: [
              OutlinedButton(
                // todo: implement later
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 12.0,
                  ),
                  side: BorderSide(color: colorScheme.onPrimary, width: 1),
                ),
                // todo: implement later
                child: Text(
                  "큰 글씨",
                  style: bodyRgMd.copyWith(color: colorScheme.onPrimary),
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
      body: IndexedStack(index: _currentIndex, children: pages),
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

              if (value != 3) {
                final ctg = ref.read(currentCtgViewmodelProvider);
                final targetCtg = _getCurrentCtgForIndex(value, ctg);

                ref
                    .read(currentCtgViewmodelProvider.notifier)
                    .setCurrentCtg(targetCtg);
                loadData(targetCtg);
              }
            },
            currentIndex: _currentIndex,
            elevation: 0,
            enableFeedback: false,
            backgroundColor: Colors.transparent,
            selectedItemColor: colorScheme.onPrimary,
            unselectedItemColor: colorScheme.onTertiary,
            selectedLabelStyle: bodySbMd,
            unselectedLabelStyle: bodyRgMd,
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
                icon: Icon(Icons.money, size: 28),
                label: "연금저축",
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
