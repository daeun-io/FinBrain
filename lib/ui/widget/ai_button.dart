import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewmodel/selected_prdt_viewmodel.dart';
import 'package:finbrain/ui/screen/ai_assist_screen.dart';
import 'package:finbrain/ui/screen/ai_comparison_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AiButton extends ConsumerWidget {
  const AiButton({
    super.key,
    required this.tag,
    required this.category,
    required this.isBtnClicked,
  });

  final String tag;
  final ProductCategory category;
  final void Function() isBtnClicked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 80,
      width: 80,
      child: FloatingActionButton(
        heroTag: tag,
        onPressed: () {
          if (tag.contains("compare")) {
            final num = ref
                .read(selectedProductsViewmodelProvider.notifier)
                .getNumOfProducts();
            print("num of selected list, $num");
            if (num == 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: colorScheme.scrim,
                  duration: Duration(seconds: 3),
                  content: Text(
                    "선택하신 상품이 없습니다! 상품을 선택해주세요",
                    style: textTheme.bodySmall!.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ),
              );
            }
            else if (!ref
                .read(selectedProductsViewmodelProvider.notifier)
                .allCategoriesSame()) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: colorScheme.scrim,
                  duration: Duration(seconds: 3),
                  content: Text(
                    "선택하신 상품들의 카테고리가 다릅니다!\n동일 카테고리의 상품을 비교해주세요",
                    style: textTheme.bodySmall!.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ),
              );
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) {
                    final ctg = ref
                        .read(selectedProductsViewmodelProvider.notifier)
                        .getCategory();
                    if (ctg == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: colorScheme.scrim,
                          duration: Duration(seconds: 3),
                          content: Text(
                            "선택하신 상품의 카테고리가 존재하지 않습니다.\n다시 시도해주세요",
                            style: textTheme.bodySmall!.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                        ),
                      );
                    }
                    return AiComparisonScreen(tag: tag, ctg: ctg!);
                  },
                ),
              );
            }
          } else {
            final screenWidth = MediaQuery.of(context).size.width;
            if (screenWidth < 600) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) =>
                      AiAssistScreen(tag: tag, category: category),
                ),
              );
            } else {
              isBtnClicked();
            }
            // final sheetWidth = screenWidth < 600
            //     ? screenWidth
            //     : screenWidth * 0.5;
            // SideSheet.right(
            //   width: sheetWidth,
            //   context: context,
            //   body: AiAssistScreen(tag: tag, category: category),
            // );
          }
        },
        backgroundColor: colorScheme.surfaceDim,
        splashColor: Colors.transparent,
        shape: const CircleBorder(),
        elevation: 0.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/ai_assist.svg"),
            Text(
              "AI 도우미",
              style: textTheme.labelSmall!.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
