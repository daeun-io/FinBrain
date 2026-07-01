import 'package:finbrain/ui/viewModel/current_ctg_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/isa_screen.dart';
import 'package:finbrain/ui/screen/product_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends ConsumerWidget{
  const ProductScreen({
    super.key,
    required this.category
  });

  final ProductScreenCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final tabList = switch(category){
      ProductScreenCategory.savings => ["정기예금", "적금", "ISA"],
      ProductScreenCategory.loan => ["주택담보대출", "전세자금대출", "개인신용대출"],
    };

    final categories = switch(category){
      ProductScreenCategory.savings => [ProductCategory.deposit, ProductCategory.installment, ProductCategory.isa],
      ProductScreenCategory.loan => [ProductCategory.mortage, ProductCategory.rent, ProductCategory.credit]
    };

    final tabView = switch(category){
      ProductScreenCategory.savings => TabBarView(children: [
        const ProductBaseScreen(productCategory: ProductCategory.deposit, filterCategory: FilterTextCategory.savings,),
        const ProductBaseScreen(productCategory: ProductCategory.installment, filterCategory: FilterTextCategory.savings),
        const IsaScreen(),
      ]),
      ProductScreenCategory.loan => TabBarView(children: [
        const ProductBaseScreen(productCategory: ProductCategory.mortage, filterCategory: FilterTextCategory.loan),
        const ProductBaseScreen(productCategory: ProductCategory.rent, filterCategory: FilterTextCategory.loan,),
        const ProductBaseScreen(productCategory: ProductCategory.credit, filterCategory: FilterTextCategory.loan),
      ]),
    };

    return DefaultTabController(
      length: 3,
        child: Column(
          children: [ 
            TabBar(
              onTap: (value) => ref.read(currentCtgViewmodelProvider.notifier).setCurrentCtg(categories[value]),
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
                borderSide: BorderSide(
                width: 2,
              ),
              ),
              indicatorColor: textPrimary,
              indicatorSize: TabBarIndicatorSize.tab,
              splashFactory: NoSplash.splashFactory,
              tabs: [
                for(final item in tabList)
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    child: Text(item),
                  )
                ]
            ),
            Expanded(
              child: tabView
            )
          ],
        )
    );
  }
}