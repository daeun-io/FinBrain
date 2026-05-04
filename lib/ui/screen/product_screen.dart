import 'package:finbrain/ui/screen/product_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:finbrain/themes/colors.dart';

class ProductScreen extends StatelessWidget{
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: white,
        appBar: TabBar(
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
              Container(
                alignment: Alignment.center,
                height: 60,
                child: Text("정기예금"),
              ),
              Container(
                alignment: Alignment.center,
                height: 60,
                child: Text("정기예금"),
              ),
              Container(
                alignment: Alignment.center,
                height: 60,
                child: Text("정기예금"),
              ),
            ]
          ),
          body: TabBarView(
            children: [
              const ProductBaseScreen(),
              const ProductBaseScreen(),
              const ProductBaseScreen(),
            ]
          ),
      )
    );
  }
}