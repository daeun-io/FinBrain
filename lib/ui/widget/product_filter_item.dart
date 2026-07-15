import 'package:finbrain/ui/viewmodel/filters_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductFilterItem extends ConsumerWidget {
  const ProductFilterItem({
    super.key,
    required this.category,
    required this.isSelected,
    required this.text,
  });

  final ProductCategory category;
  final bool isSelected;
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    var localIsSelected = isSelected;

    return GestureDetector(
      onTap: () {
        ref
            .read(dialogFiltersViewModelProvider(category).notifier)
            .toggleSelected(category, text, localIsSelected);
      },
      child: Card(
        color: localIsSelected
            ? colorScheme.surfaceContainerHigh
            : colorScheme.surface,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: localIsSelected
                ? colorScheme.surfaceContainerHigh
                : colorScheme.outline,
            width: 1.0,
          ),
          borderRadius: BorderRadiusGeometry.circular(10.0),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(
            text,
            style: (localIsSelected)
                ? textTheme.titleMedium!.copyWith(color: colorScheme.onSurface)
                : textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary),
          ),
        ),
      ),
    );
  }
}
