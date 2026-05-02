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
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: textSecondary,
            ),
            indicator: UnderlineTabIndicator(
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
              Text("tab1"),
              Text("tab2"),
              Text("tab3"),
            ]
          ),
      )
    );
  }
}