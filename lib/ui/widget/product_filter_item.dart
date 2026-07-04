import 'package:finbrain/ui/viewmodel/filters_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductFilterItem extends ConsumerWidget {
  const ProductFilterItem({
    super.key,
    required this.category,
    required this.isSelected,
    required this.text,
  });

  final FilterTextCategory category;
  final bool isSelected;
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var localIsSelected = isSelected;
    
    return GestureDetector(
      onTap: () {
        ref
            .read(dialogFiltersViewModelProvider(category).notifier)
            .toggleSelected(text, localIsSelected);
      },
      child: Card(
        color: localIsSelected ? primary700 : white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: localIsSelected ? primary700 : primary300,
            width: 1.0,
          ),
          borderRadius: BorderRadiusGeometry.circular(10.0),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(
            text,
            style: TextStyle(
              color: localIsSelected ? white : black,
              fontSize: 12.0,
              fontWeight: localIsSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
