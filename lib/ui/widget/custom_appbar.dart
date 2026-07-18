import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/themes/text_theme.dart';
import 'package:finbrain/ui/screen/archive_screen.dart';
import 'package:finbrain/ui/screen/isa_guide_screen.dart';
import 'package:finbrain/ui/viewModel/text_theme_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({
    super.key,
    required this.screen,
    required this.title,
    this.product,
    this.page,
  });

  final String screen;
  final String title;

  final int? page;
  final FinancialProduct? product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final currTxtTheme = ref.watch(textThemeViewmodelProvider);

    final isPhone = MediaQuery.of(context).size.width < 600;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return AppBar(
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
          OutlinedButton(
            onPressed: () {
              ref
                  .read(textThemeViewmodelProvider.notifier)
                  .changeTxtTheme(
                    (currTxtTheme == bigTextTheme) ? true : false,
                  );
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 12.0,
              ),
              side: BorderSide(color: colorScheme.onPrimary, width: 1),
            ),
            child: Text(
              (currTxtTheme == bigTextTheme) ? "작은 글씨" : "큰 글씨",
              style: textTheme.titleMedium!.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
          ),
          const SizedBox(width: 8),
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
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const ArchiveScreen()),
              );
            },
            icon: Icon(
              Icons.archive_sharp,
              color: colorScheme.surfaceContainerHighest,
              size: 32,
            ),
          ),
        ],
        "detail" => [
          IconButton(
            onPressed: () {
              ref
                  .read(
                    fetchProductViewmodelProvider(
                      product!.commonInfo.category,
                      "$page",
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
