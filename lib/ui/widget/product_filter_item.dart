import 'package:finbrain/provider/filters_provider.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductFilterItem extends ConsumerStatefulWidget{
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
      onTap: (){
        setState(() {
          ref.read(filtersProvider.notifier).toggleSelected(widget.text, localIsSelected);
        });
      },
      child: Card(
        // selected color
        color: localIsSelected ? primary700 : primary300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(34.5),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              color: localIsSelected ? white : textPrimary,
              fontSize: 12.0,
              fontWeight: FontWeight.w400
            ),
          ),
        ),
      ),
    );
  }
}