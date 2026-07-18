import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/product_base_screen.dart';
import 'package:finbrain/ui/viewModel/product_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/current_ctg_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/current_page_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_tapbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoanScreen extends ConsumerWidget {
  const LoanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

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

     void tapFunction(value) {
      ref
          .read(currentCtgViewmodelProvider.notifier)
          .setCurrentCtg(categories[value]);
      final page = ref.read(currentPageViewmodelProvider(categories[value]));
      ref.read(fetchProductViewmodelProvider(categories[value], "$page"));
    }

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Column(
        children: [
          CustomTapbar(tabList: tabList, isIsaScreen: false, onTapFunc: tapFunction,),
          Expanded(child: TabBarView(children: tabView)),
        ],
      ),
    );
  }
}
