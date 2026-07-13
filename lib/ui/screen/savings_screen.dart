import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/isa_screen.dart';
import 'package:finbrain/ui/screen/product_base_screen.dart';
import 'package:finbrain/ui/viewModel/current_ctg_viewmodel.dart';
import 'package:finbrain/ui/viewModel/current_page_viewmodel.dart';
import 'package:finbrain/ui/viewModel/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavingsScreen extends ConsumerWidget {
  const SavingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final tabList = const ["정기예금", "적금", "ISA"];
    final categories = const [
      ProductCategory.deposit,
      ProductCategory.installment,
      ProductCategory.isaJoin,
    ];
    final tabView = const [
      ProductBaseScreen(category: ProductCategory.deposit),
      ProductBaseScreen(category: ProductCategory.installment),
      IsaScreen(),
    ];

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Column(
        children: [
          TabBar(
            onTap: (value) {
              ref
                  .read(currentCtgViewmodelProvider.notifier)
                  .setCurrentCtg(categories[value]);
              final page = ref.read(
                currentPageViewmodelProvider(categories[value]),
              );
              ref.read(
                fetchProductViewmodelProvider(categories[value], "$page"),
              );
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
