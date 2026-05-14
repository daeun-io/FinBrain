import 'package:finbrain/ui/product_category.dart';
import 'package:finbrain/ui/screen/isa_screen.dart';
import 'package:finbrain/ui/screen/product_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:finbrain/themes/colors.dart';

class ProductScreen extends StatelessWidget{
  const ProductScreen({
    super.key,
    required this.category
  });

  final ProductCategory category;

  @override
  Widget build(BuildContext context) {
    
    var tabList = switch(category){
      ProductCategory.savings => ["정기예금", "적금", "ISA"],
      ProductCategory.loan => ["주택담보대출", "전세자금대출", "개인신용대출"],
      _ => null
    };

    var tabView = switch(category){
      ProductCategory.savings => TabBarView(children: [
        const ProductBaseScreen(subCategory: SubCategory.deposit,),
        const ProductBaseScreen(subCategory: SubCategory.installment,),
        const IsaScreen(),
      ]),
      ProductCategory.loan => TabBarView(children: [
        const ProductBaseScreen(subCategory: SubCategory.mortage,),
        const ProductBaseScreen(subCategory: SubCategory.rent,),
        const ProductBaseScreen(subCategory: SubCategory.credit,),
      ]),
      _ => null
    };

    return DefaultTabController(
      length: 3,
        child: Column(
          children: [ 
            TabBar(
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
                for(final item in tabList!)
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    child: Text(item),
                  )
                ]
            ),
            Expanded(
              child: tabView!
            )
          ],
        )
    );
  }
}