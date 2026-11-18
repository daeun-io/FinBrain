import 'package:finbrain/product_categories.dart';
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
  });

  final ProductCategory ctg;
  final bool isProduct;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);
    final textStyle = textTheme.bodyMedium!.copyWith(
      color: colorScheme.onSecondary,
    );
    return Center(
      child: Text(
        (isProduct) ? "검색 조건에 맞는 금융 상품이 없습니다" : "검색 조건과 일치하는 데이터가 없습니다",
        style: textStyle,
      ),
    );
  }
}
