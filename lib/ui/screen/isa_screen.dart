import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/product_categories.dart';
import 'package:finbrain/ui/screen/isa_base_screen.dart';
import 'package:finbrain/ui/screen/isa_mp_screen.dart';
import 'package:flutter/material.dart';

class IsaScreen extends StatelessWidget{
  const IsaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children:[
            Card(
              color: primary100,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              elevation: 0,
              child: TabBar(
                labelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: white,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: textSecondary
                ),
                indicator: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: primary700,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                tabs: [
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    child: const Text("업권별 가입 현황"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    child: const Text("운용 현황"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    child: const Text("MP 수익률"),
                  ),
                ]
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  const IsaBaseScreen(category: IsaScreenCategory.join,),
                  const IsaBaseScreen(category: IsaScreenCategory.operation,),
                  const IsaMpScreen()
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}