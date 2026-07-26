import 'package:finbrain/ui/viewmodel/text_theme_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowingErrorWidget extends ConsumerWidget {
  const ShowingErrorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return Center(
      child: Text(
        "오류가 발생했습니다. 다시 시도해주세요",
        style: textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary),
      ),
    );
  }
}
