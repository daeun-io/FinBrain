import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Text(
        "데이터 및 상품이 존재하지 않습니다",
        style: textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary),
      ),
    );
  }
}
