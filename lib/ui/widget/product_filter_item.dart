import 'package:finbrain/provider/filters_provider.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductFilterItem extends ConsumerStatefulWidget {
  const ProductFilterItem({
    super.key,
    required this.isSelected,
    required this.text,
  });

  final bool isSelected;
  final String text;

  @override
  ConsumerState<ProductFilterItem> createState() => _ProductFilterItemState();
}

class _ProductFilterItemState extends ConsumerState<ProductFilterItem> {
  @override
  Widget build(BuildContext context) {
    var localIsSelected = widget.isSelected;
    return GestureDetector(
      onTap: () {
        setState(() {
          ref
              .read(filtersNotifierProvider.notifier)
              .toggleSelected(widget.text, localIsSelected);
        });
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
            widget.text,
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
