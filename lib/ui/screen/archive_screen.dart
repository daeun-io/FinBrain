import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/archive_tabview_screen.dart';
import 'package:finbrain/ui/widget/custom_appbar.dart';
import 'package:finbrain/ui/widget/custom_tapbar.dart';
import 'package:flutter/material.dart';

// AI 요약 및 비교 분석 저장소
// AI response archive(summary and comparison)
class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final tabList = ["AI 대화 요약", "AI 비교 분석"];
    final tabView = TabBarView(
      children: const [
        ArchiveTabViewScreen(category: ArchiveCategory.summary),
        ArchiveTabViewScreen(category: ArchiveCategory.comparison),
      ],
    );

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(screen: "archive", title: "기록 보관소"),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            CustomTapbar(tabList: tabList, isIsaScreen: false,),
            Expanded(child: tabView),
          ],
        ),
      ),
    );
  }
}
