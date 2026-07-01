import 'package:finbrain/ui/viewModel/selected_prdt_viewmodel.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/screen/ai_assist_screen.dart';
import 'package:finbrain/ui/screen/ai_comparison_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AiButton extends ConsumerWidget {
  const AiButton({super.key, required this.tag});

  final String tag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 80,
      width: 80,
      child: FloatingActionButton(
        heroTag: tag,
        onPressed: () {
          if (tag.contains("compare")) {
            if (!ref
                .read(selectedProductsViewmodelProvider.notifier)
                .allCategoriesSame()) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 3),
                  content: const Text(
                    "선택하신 상품들의 카테고리가 다릅니다!\n동일 카테고리의 상품을 비교해주세요",
                  ),
                ),
              );
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => AiComparisonScreen(tag: tag),
                ),
              );
            }
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => AiAssistScreen(tag: tag)),
            );
          }
        },
        backgroundColor: primary900,
        splashColor: Colors.transparent,
        shape: const CircleBorder(),
        elevation: 0.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/ai_assist.svg"),
            const Text(
              "AI 도우미",
              style: TextStyle(
                color: textTertiary,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
