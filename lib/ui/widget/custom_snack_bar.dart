import 'package:finbrain/ui/viewModel/text_theme_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomSnackBar {
  static void show(
    BuildContext context,
    WidgetRef ref, {
    required String text,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: colorScheme.scrim,
        duration: Duration(seconds: 3),
        content: Text(
          text,
          style: textTheme.bodySmall!.copyWith(color: colorScheme.onSecondary),
        ),
      ),
    );
  }
}
