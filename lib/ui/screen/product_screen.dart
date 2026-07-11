import 'package:finbrain/ui/viewmodel/current_ctg_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/isa_screen.dart';
import 'package:finbrain/ui/screen/product_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key, required this.category});

  final ProductScreenCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final tabList = switch (category) {
      ProductScreenCategory.savings => ["정기예금", "적금", "ISA"],
      ProductScreenCategory.loan => ["주택담보대출", "전세자금대출", "개인신용대출"],
    };

    final categories = switch (category) {
      ProductScreenCategory.savings => [
        ProductCategory.deposit,
        ProductCategory.installment,
        ProductCategory.isaJoin,
      ],
      ProductScreenCategory.loan => [
        ProductCategory.mortgage,
        ProductCategory.rent,
        ProductCategory.credit,
      ],
    };

    final tabView = switch (category) {
      ProductScreenCategory.savings => TabBarView(
        children: [
          const ProductBaseScreen(category: ProductCategory.deposit),
          const ProductBaseScreen(category: ProductCategory.installment),
          const IsaScreen(),
        ],
      ),
      ProductScreenCategory.loan => TabBarView(
        children: [
          const ProductBaseScreen(category: ProductCategory.mortgage),
          const ProductBaseScreen(category: ProductCategory.rent),
          const ProductBaseScreen(category: ProductCategory.credit),
        ],
      ),
    };

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            onTap: (value) => ref
                .read(currentCtgViewmodelProvider.notifier)
                .setCurrentCtg(categories[value]),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: colorScheme.onPrimary, width: 2.0),
            ),
            labelColor: colorScheme.onPrimary,
            unselectedLabelColor: colorScheme.onTertiary,
            dividerColor: colorScheme.onTertiary,
            labelStyle: textTheme.titleMedium,
            unselectedLabelStyle: textTheme.bodyMedium,
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
          Expanded(child: tabView),
        ],
      ),
    );
  }
}
