import 'package:finbrain/ui/viewModel/current_ctg_viewmodel.dart';
import 'package:finbrain/ui/viewModel/product_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/liked_screen.dart';
import 'package:finbrain/ui/screen/product_base_screen.dart';
import 'package:finbrain/ui/screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:finbrain/themes/colors.dart';
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
    if (ctg != ProductCategory.isa) {
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
            ctgInVM == ProductCategory.isa) {
          return ctgInVM;
        }
        return ProductCategory.deposit;
      case 1:
        if (ctgInVM == ProductCategory.mortage ||
            ctgInVM == ProductCategory.rent ||
            ctgInVM == ProductCategory.credit) {
          return ctgInVM;
        }
        return ProductCategory.mortage;
      case 2:
        return ProductCategory.annuity;
      default:
        return ctgInVM;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ProductCategory>(currentCtgViewmodelProvider, (prev, next) {
      if (_currentIndex != 3) {
        loadData(next);
      }
    });

    final pages = [
      ProductScreen(category: ProductScreenCategory.savings),
      ProductScreen(category: ProductScreenCategory.loan),
      ProductBaseScreen(
        productCategory: ProductCategory.annuity,
        filterCategory: FilterTextCategory.annuity,
      ),
      const LikedScreen(),
    ];

    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: AppBar(
            backgroundColor: white,
            scrolledUnderElevation: 0.0,
            leading: Image.asset("assets/images/app_icon.png"),
            title: const Text(
              "FinBrain",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
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
                  side: const BorderSide(color: textPrimary, width: 1),
                ),
                // todo: implement later
                child: const Text(
                  "큰 글씨",
                  style: TextStyle(color: textPrimary, fontSize: 14.0),
                ),
              ),
              const SizedBox(width: 20, height: 60),
            ],
          ),
        ),
      ),
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: primary100,
          border: Border(top: BorderSide(color: primary300, width: 1.0)),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
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
            selectedItemColor: textPrimary,
            unselectedItemColor: textSecondary,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
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
