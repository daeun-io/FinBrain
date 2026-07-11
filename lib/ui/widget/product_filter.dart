import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/widget/product_dialog.dart';
import 'package:flutter/material.dart';

class ProductFilter extends StatefulWidget {
  const ProductFilter({
    super.key,
    required this.category,
  });

  final ProductCategory category;

  @override
  State<ProductFilter> createState() => _ProductFilterState();
}

class _ProductFilterState extends State<ProductFilter> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.25,
      child: TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        onPressed: () {
          setState(() {
            showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return ProductDialog(
                  category: widget.category,
                );
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
              const SizedBox(width: 4.0,),
              Text(
                "필터",
                style: textTheme.titleLarge!.copyWith(color: colorScheme.onSurface)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
