import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewmodel/current_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoDataFound extends ConsumerWidget {
  const NoDataFound({
    super.key,
    required this.ctg,
    required this.isProduct,
    required this.isLastPage,
  });

  final ProductCategory ctg;
  final bool isProduct;
  final bool isLastPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cPage = ref.watch(currentPageViewmodelProvider(ctg));

    return Center(
      child: (isProduct)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                text(context, "검색 조건에 맞는 상품이 없습니다"),
                const SizedBox(height: 16.0),
                if (!isLastPage)
                  text(
                    context,
                    "아직 불러오지 않은 상품이 있을 수 있으니, 화면을 아래로 스크롤해 더 많은 상품을 확인해주세요",
                  ),
                if (isLastPage && cPage != 1) ...[
                  text(context, "현재가 마지막 페이지입니다. 다시 첫 페이지로 돌아가시겠습니까?"),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      button(context, "예", () {
                        ref
                            .read(currentPageViewmodelProvider(ctg).notifier)
                            .setCurrentPage(1);
                      }),
                      const SizedBox(width: 16.0),
                      button(context, "아니오", () {}),
                    ],
                  ),
                ],
              ],
            )
          : text(context, "검색 조건과 일치하는 데이터가 없습니다."),
    );
  }

  Widget text(BuildContext context, String text) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Text(
      text,
      style: textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary),
      textAlign: TextAlign.center,
    );
  }

  ElevatedButton button(
    BuildContext context,
    String btnTxt,
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
      child: text(context, btnTxt),
    );
  }
}
