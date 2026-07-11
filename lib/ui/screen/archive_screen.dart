import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/archive_tabview_screen.dart';
import 'package:flutter/material.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final tabList = ["AI 대화 요약", "AI 비교 분석"];
    final tabView = TabBarView(
      children: const [ ArchiveTabViewScreen(category: ArchiveCategory.summary,), ArchiveTabViewScreen(category: ArchiveCategory.comparison,)],
    );

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new, color: colorScheme.onPrimary),
        ),
        title: Text(
          "아카이브",
          style: textTheme.headlineMedium!.copyWith(color: colorScheme.onPrimary)
        ),
        titleSpacing: -6.0,
      ),
      body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
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
              Expanded(child: tabView),
            ],
          ),
        ),
      );
  }
}
