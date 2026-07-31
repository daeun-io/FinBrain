import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewmodel/selected_prdt_viewmodel.dart';
import 'package:finbrain/ui/screen/ai_assist_screen.dart';
import 'package:finbrain/ui/screen/ai_comparison_screen.dart';
import 'package:finbrain/ui/viewmodel/text_theme_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

// AI 도우미 및 비교 버튼
// AI assist and comparison button
class AiButton extends ConsumerWidget {
  const AiButton({
    super.key,
    required this.tag,
    required this.name,
    required this.category,
    required this.isBtnClicked,
  });

  final String tag;                       // 상품(들) 코드 및 이름(product(s) code/codes or name/names)
  final String name;                      // 상품(들) 이름(product(s) name/names)
  final ProductCategory category;         // 상품(들) 카테고리(product(s) category)
  final void Function() isBtnClicked;     // 태블릿 일 때 사용(Use when device is tablet)

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return SizedBox(
      height: 80,
      width: 80,
      child: FloatingActionButton(
        heroTag: tag,
        onPressed: () {
          // 태그에 compare이 있으면 비교 분석
          // If tag contains "compare", compare products
          if (tag.contains("compare")) {
            final num = ref
                .read(selectedProductsViewmodelProvider.notifier)
                .getNumOfProducts();
            if (num < 2) {
              ScaffoldMessenger.of(context).showSnackBar(
                snackbar(context, "최소 2개 이상의 상품을 선택해주세요!")
              );
            }
            else if (!ref
                .read(selectedProductsViewmodelProvider.notifier)
                .allCategoriesSame()) {
              ScaffoldMessenger.of(context).showSnackBar(
                snackbar(context, "선택하신 상품들의 카테고리가 다릅니다!\n동일 카테고리의 상품을 비교해주세요")
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
                        snackbar(context, "선택하신 상품의 카테고리가 존재하지 않습니다.\n다시 시도해주세요"),
                      );
                      return const SizedBox.shrink();
                    }
                    return AiComparisonScreen(tag: tag, name: name, ctg: ctg);
                  },
                ),
              );
            }
          // 태그에 compare이 없으면 AI 채팅
          // Else, do AI chats about products
          } else {
            // 핸드폰이면 네비게이션
            // If device is phone, navigate to screen
            final screenWidth = MediaQuery.of(context).size.width;
            if (screenWidth < 600) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) =>
                      AiAssistScreen(tag: tag, category: category, name: name),
                ),
              );
            // 아니면 스플릿 뷰에 보이기
            // Else, display in split view
            } else {
              isBtnClicked();
            }
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

  SnackBar snackbar(BuildContext context, String text) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SnackBar(
      backgroundColor: colorScheme.scrim,
      duration: const Duration(seconds: 3),
      content: Text(
        text,
        style: textTheme.bodySmall!.copyWith(color: colorScheme.onSecondary),
      ),
    );
  }
}
