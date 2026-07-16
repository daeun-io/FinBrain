import 'package:flutter/material.dart';

class ShowingErrorWidget extends StatelessWidget {
  const ShowingErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Center(
        child: Text(
          "오류가 발생했습니다. 다시 시도해주세요",
          style: textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary),
        ),
      ),
    );
  }
}
