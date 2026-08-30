import 'package:finbrain/ui/viewmodel/text_theme_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AiExampleQuery extends ConsumerWidget {
  const AiExampleQuery({super.key, required this.query, required this.tapFunc});

  final String query;
  final Function() tapFunc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return GestureDetector(
      onTap: tapFunc,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          border: Border.all(color: colorScheme.outline, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          query,
          style: textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary),
        ),
      ),
    );
  }
}
