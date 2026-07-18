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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final style = textTheme.bodyMedium!.copyWith(
      color: colorScheme.onSecondary,
    );

    final cPage = ref.watch(currentPageViewmodelProvider(ctg));

    return Center(
      child: (isProduct)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("검색 조건에 맞는 상품이 없습니다", style: style),
                const SizedBox(height: 16.0),
                if (!isLastPage)
                  Text(
                    "아직 불러오지 않은 상품이 있을 수 있으니, 화면을 아래로 스크롤하여 더 많은 상품을 확인 후  다시 시도해주세요",
                    style: style,
                    textAlign: TextAlign.center,
                  ),
                if (isLastPage && cPage != 1) ...[
                  Text("현재가 마지막 페이지입니다. 다시 첫 페이지로 돌아가시겠습니까?", style: style, textAlign: TextAlign.center),
                  const SizedBox(height: 24.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(currentPageViewmodelProvider(ctg).notifier)
                              .setCurrentPage(1);
                        },
                        child: Text("예", style: style),
                      ),
                      const SizedBox(width: 16.0,),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("아니요", style: style),
                      ),
                    ],
                  ),
                ],
              ],
            )
          : Text("검색 조건과 일치하는 데이터가 없습니다.", style: style),
    );
  }
}
