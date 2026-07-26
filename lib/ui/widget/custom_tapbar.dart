import 'package:flutter/material.dart';

class CustomTapbar extends StatelessWidget {
  const CustomTapbar({
    super.key,
    required this.tabList,
    required this.isIsaScreen,
    this.onTapFunc,
    this.controller,
  });

  final List<String> tabList;         // 탭 리스트
  final bool isIsaScreen;             // ISA 스크린 여부
  final Function(int)? onTapFunc;     // 탭 시 실행할 함수
  final TabController? controller;    // 컨트롤러

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // ISA 스크린여부에 따라 디자인 변경
    // Change design whether it is called from ISA screen or not
    return TabBar(
      onTap: onTapFunc,
      controller: controller,
      indicator: (isIsaScreen)
          ? BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: colorScheme.surfaceContainerHigh,
            )
          : UnderlineTabIndicator(
              borderSide: BorderSide(color: colorScheme.onPrimary, width: 2.0),
            ),
      labelColor: (isIsaScreen) ? colorScheme.onSurface : colorScheme.onPrimary,
      unselectedLabelColor: colorScheme.onTertiary,
      dividerColor: (isIsaScreen) ? colorScheme.surface : colorScheme.onTertiary,
      labelStyle: textTheme.titleMedium,
      unselectedLabelStyle: textTheme.bodyMedium,
      indicatorSize: TabBarIndicatorSize.tab,
      splashFactory: NoSplash.splashFactory,
      tabs: [
        for (final item in tabList)
          Container(
            alignment: Alignment.center,
            height: (isIsaScreen) ? 40 : 60,
            child: FittedBox(fit: BoxFit.scaleDown, child: Text(item)),
          ),
      ],
    );
  }
}
