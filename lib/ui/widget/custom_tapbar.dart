import 'package:flutter/material.dart';

class CustomTapbar extends StatelessWidget {
  const CustomTapbar({
    super.key,
    required this.tabList,
    required this.isIsaScreen,
    this.onTapFunc,
    this.controller,
  });

  final List<String> tabList;
  final bool isIsaScreen;
  final Function(int)? onTapFunc;
  final TabController? controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
