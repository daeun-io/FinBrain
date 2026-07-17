import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key, required this.isProduct});

  final bool isProduct;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Text(
        (isProduct) ?
        """
        검색 조건에 맞는 상품이 없습니다

        아직 불러오지 않은 상품이 있을 수 있으니,
        화면을 아래로 스크롤하여 더 많은 상품을 확인한 뒤 다시 시도해주세요
        """ : "검색 조건과 일치하는 데이터가 없습니다.",
        style: textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary),
      ),
    );
  }
}
