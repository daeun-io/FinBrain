import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/ui/screen/isa_guide_screen.dart';
import 'package:finbrain/ui/screen/my_page_screen.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 애플리케이션 특화 앱바
// Application specialized app bar
class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({
    super.key,
    required this.screen,
    required this.title,
    this.product,
    this.page,
  });

  final String screen;      // 호출하는 화면 이름(screen name)
  final String title;       // 앱 바 타이틀(app bar title)

  final int? page;
  final FinancialProduct? product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final isPhone = MediaQuery.of(context).size.width < 600;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return AppBar(
      // 스크린에 따라 배경색 변경
      // Change background color based on screen
      backgroundColor: ["archive", "main", "calculator"].contains(screen)
          ? colorScheme.primary
          : colorScheme.tertiary,
      scrolledUnderElevation: 0.0,
      automaticallyImplyLeading: false,
      leading: switch (screen) {
        "main" => Image.asset(
          (isLightMode)
              ? "assets/images/icon_light.png"
              : "assets/images/icon_dark.png",
        ),
        // 기기에 따라 백버튼 추가/삭제
        // Display back button based on device
        "ai_assist" =>
          (isPhone) ? backButton(context, colorScheme.onPrimary) : null,
        _ => backButton(context, colorScheme.onPrimary),
      },
      title: Text(
        title,
        style: (screen == "main")
            ? textTheme.headlineMedium!.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w900,
              )
            : textTheme.headlineMedium!.copyWith(color: colorScheme.onPrimary),
      ),
      titleSpacing: switch (screen) {
        "main" => -4.0,
        "ai_assist" => (isPhone) ? -6.0 : 24.0,
        _ => -6.0,
      },
      actions: switch (screen) {
        "main" => [
          // ISA 가이드 스크린으로 이동하는 버튼
          // Navigate to guide screen button
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const IsaGuideScreen()),
              );
            },
            icon: Icon(
              Icons.info,
              color: colorScheme.surfaceContainerHighest,
              size: 32,
            ),
          ),
          // 마이페이지로 이동하는 버튼
          // Navigate to my page screen button
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const MyPageScreen()),
              );
            },
            icon: Icon(
              Icons.person,
              color: colorScheme.surfaceContainerHighest,
              size: 32,
            ),
          ),
        ],
        "detail" => [
          // 관심 상품 선택/미선택 아이콘
          // Toggle product as liked/unliked button
          IconButton(
            onPressed: () {
              ref
                  .read(
                    fetchProductViewmodelProvider(
                      product!.commonInfo.category,
                      page ?? 1,
                    ).notifier,
                  )
                  .toggleLiked(product!);
            },
            icon: product!.commonInfo.isLiked
                ? Icon(
                    Icons.favorite,
                    color: colorScheme.onPrimaryFixed,
                    size: 32.0,
                  )
                : Icon(
                    Icons.favorite,
                    color: colorScheme.onPrimaryFixedVariant,
                    size: 32.0,
                  ),
          ),
        ],
        _ => [],
      },
    );
  }

  IconButton backButton(BuildContext context, Color color) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: color, // colorScheme.onPrimary,
      ),
    );
  }
}
