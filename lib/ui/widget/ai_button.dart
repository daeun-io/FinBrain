import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/ai_assist_screen.dart';
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

  // 상품 코드 및 이름(product code or name)
  final String? tag;  
  // 상품 이름(product name)         
  final String? name;
  // 상품 카테고리(product category)  
  final ProductCategory category;
  // 태블릿이거나 상품 비교 분석시 사용
  // Used when device is tablet or comparing products
  final void Function() isBtnClicked;

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
          // 핸드폰이면 AI 어시스트 스크린으로 네비게이션
          // If device is phone, navigate to AI assist screen
          final screenWidth = MediaQuery.of(context).size.width;
          if (screenWidth < 600 && category != ProductCategory.liked) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) =>
                    AiAssistScreen(tag: tag!, category: category, name: name!),
              ),
            );
            // 아니면 스플릿 뷰에 보이기
            // Else, display in split view
          } else {
            isBtnClicked();
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
