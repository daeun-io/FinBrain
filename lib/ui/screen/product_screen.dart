import 'package:finbrain/data/viewModel/product_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/isa_screen.dart';
import 'package:finbrain/ui/screen/product_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key, required this.category});

  final ProductScreenCategory category;

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late List<ProductCategory> _categories;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _categories = switch (widget.category) {
      ProductScreenCategory.savings => [
        ProductCategory.deposit,
        ProductCategory.installment,
        ProductCategory.isa,
      ],
      ProductScreenCategory.loan => [
        ProductCategory.mortage,
        ProductCategory.rent,
        ProductCategory.credit,
      ],
      _ => [ProductCategory.annuity],
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(productViewmodelProvider.notifier)
          .fetchFinlifeProducts(ProductCategory.deposit, "020000", "1");
    });

    _controller.addListener(() {
      if (!_controller.indexIsChanging) {
        final currentCtg = _categories[_controller.index];
        if (currentCtg == ProductCategory.isa) {
          ref
              .read(productViewmodelProvider.notifier)
              .fetchIsaMpProducts("1", "100", "2026", "", "", "");
        } else {
          ref
              .read(productViewmodelProvider.notifier)
              .fetchFinlifeProducts(currentCtg, "020000", "1");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabList = switch (widget.category) {
      ProductScreenCategory.savings => ["정기예금", "적금", "ISA"],
      ProductScreenCategory.loan => ["주택담보대출", "전세자금대출", "개인신용대출"],
      _ => [],
    };
    final views = switch (widget.category) {
      ProductScreenCategory.savings => [
        ProductBaseScreen(
          productCategory: ProductCategory.deposit,
          filterCategory: FilterTextCategory.savings,
        ),
        const ProductBaseScreen(
          productCategory: ProductCategory.installment,
          filterCategory: FilterTextCategory.savings,
        ),
        const IsaScreen(),
      ],
      ProductScreenCategory.loan => [
        const ProductBaseScreen(
          productCategory: ProductCategory.mortage,
          filterCategory: FilterTextCategory.loan,
        ),
        const ProductBaseScreen(
          productCategory: ProductCategory.rent,
          filterCategory: FilterTextCategory.loan,
        ),
        const ProductBaseScreen(
          productCategory: ProductCategory.credit,
          filterCategory: FilterTextCategory.loan,
        ),
      ],
      _ => [
        ProductBaseScreen(
          productCategory: ProductCategory.annuity,
          filterCategory: FilterTextCategory.annuity,
        ),
      ],
    };
    return (widget.category == ProductScreenCategory.annuity)
        ? ProductBaseScreen(
            productCategory: ProductCategory.annuity,
            filterCategory: FilterTextCategory.annuity,
          )
        : Column(
            children: [
              TabBar(
                controller: _controller,
                labelColor: textPrimary,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(width: 2),
                ),
                indicatorColor: textPrimary,
                indicatorSize: TabBarIndicatorSize.tab,
                splashFactory: NoSplash.splashFactory,
                tabs: [
                  for (final item in tabList)
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      child: Text(item),
                    ),
                ],
              ),
              Expanded(
                child: TabBarView(controller: _controller, children: views),
              ),
            ],
          );
  }
}
