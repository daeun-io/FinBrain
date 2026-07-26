import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewmodel/current_page_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/text_theme_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 데이터 미발견 시 위젯
// Widget when data is not found
class NoDataFound extends ConsumerWidget {
  const NoDataFound({
    super.key,
    // 데이터 카테고리(product category)
    required this.ctg,           
    // 금융 상품인가 여부: ISA 가입 및 운용 데이터면 false
    // Is financial product: if data are ISA join/management status, then false
    required this.isProduct,
    required this.isLastPage,
  });

  final ProductCategory ctg;
  final bool isProduct;
  final bool isLastPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cPage = ref.watch(currentPageViewmodelProvider(ctg));
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);
    final textStyle = textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary);

    return Center(
      child: (isProduct)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                text(context, "검색 조건에 맞는 상품이 없습니다", textStyle),
                const SizedBox(height: 16.0),
                if (!isLastPage)
                  text(
                    context,
                    "아직 불러오지 않은 상품이 있을 수 있으니, 화면을 아래로 스크롤해 더 많은 상품을 확인해주세요",
                    textStyle
                  ),
                // 마지막 페이지에 도달하면 첫 페이지로 이동하는 로직 제공
                // Move to the first page when reached to the last
                if (isLastPage && cPage != 1) ...[
                  text(
                    context, 
                    "현재가 마지막 페이지입니다. 다시 첫 페이지로 돌아가시겠습니까?", 
                    textStyle
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      button(
                        context, 
                        "예", 
                        textStyle,
                        () {
                        ref
                            .read(currentPageViewmodelProvider(ctg).notifier)
                            .setCurrentPage(1);
                      }),
                      const SizedBox(width: 16.0),
                      button(
                        context, 
                        "아니오", 
                        textStyle,
                        () {}
                      ),
                    ],
                  ),
                ],
              ],
            )
          : text(context, "검색 조건과 일치하는 데이터가 없습니다.", textStyle),
    );
  }

  Widget text(BuildContext context, String text, TextStyle style) {
    return Text(
      text,
      style: style,
      textAlign: TextAlign.center,
    );
  }

  // 첫 페이지 이동 버튼(예/아니요)
  // Move to the first page button(yes/no)
  ElevatedButton button(
    BuildContext context,
    String btnTxt,
    TextStyle style,
    void Function() pressFunc,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: pressFunc,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.secondary,
        shadowColor: colorScheme.surface,
        side: BorderSide(
          color: colorScheme.outline, // Change your border color here
          width: 1.0, // Change border thickness
        ),
      ),
      child: text(context, btnTxt, style),
    );
  }
}
