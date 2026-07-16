import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/product_base_screen.dart';
import 'package:finbrain/ui/viewModel/product_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/current_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoanScreen extends ConsumerWidget {
  const LoanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final tabList = const ["주택담보대출", "전세자금대출", "개인신용대출"];
    final categories = const [
      ProductCategory.mortgage,
      ProductCategory.rent,
      ProductCategory.credit,
    ];
    final tabView = const [
      ProductBaseScreen(category: ProductCategory.mortgage),
      ProductBaseScreen(category: ProductCategory.rent),
      ProductBaseScreen(category: ProductCategory.credit),
    ];

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Column(
        children: [
          TabBar(
            onTap: (value){
               final page = ref.read(currentPageViewmodelProvider(categories[value]));
               ref.read(fetchProductViewmodelProvider(categories[value], "$page"));
            },   
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
          Expanded(child: TabBarView(children: tabView)),
        ],
      ),
    );
  }
}
