import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/isa_screen.dart';
import 'package:finbrain/ui/screen/product_base_screen.dart';
import 'package:finbrain/ui/viewmodel/current_ctg_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/current_page_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_tapbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 예적금 상품 스크린
class SavingsScreen extends ConsumerWidget {
  const SavingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 예적금 상품 탭 리스트
    // Savings product tab list
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
    
    // 탭 선택에 따라 카테고리 변경
    // Change current category based on tab index
    void tapFunction(value) {
      final ctg = categories[value];
      ref
          .read(currentCtgViewmodelProvider.notifier)
          .setCurrentCtg(ctg);
      final page = ref.read(currentPageViewmodelProvider(ctg));
      ref.read(fetchProductViewmodelProvider(ctg, page));
    }

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Column(
        children: [
          CustomTapbar(tabList: tabList, isIsaScreen: false, onTapFunc: tapFunction),
          Expanded(child: TabBarView(children: tabView)),
        ],
      ),
    );
  }
}
