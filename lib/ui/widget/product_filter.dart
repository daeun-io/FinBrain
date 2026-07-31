import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewmodel/text_theme_viewmodel.dart';
import 'package:finbrain/ui/widget/product_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 필터 다이얼로그를 띄우는 버튼
// Button showing filter dialog
class ProductFilter extends ConsumerStatefulWidget {
  const ProductFilter({super.key, required this.category});

  final ProductCategory category;

  @override
  ConsumerState<ProductFilter> createState() => _ProductFilterState();
}

class _ProductFilterState extends ConsumerState<ProductFilter> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 0, maxWidth: 100),
      child: TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        onPressed: () {
          setState(() {
            showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return ProductDialog(category: widget.category);
              },
            );
          });
        },
        child: Container(
          color: colorScheme.surfaceContainerHigh,
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.tune, color: colorScheme.onSurface, size: 20.0),
              const SizedBox(width: 4.0),
              Text(
                "필터",
                style: textTheme.titleLarge!.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
