import 'package:finbrain/themes/colors.dart';
import 'package:flutter/material.dart';

class ProductFilterItem extends StatefulWidget{
  ProductFilterItem({
    super.key,
    required this.isSelected,
    required this.text
  });

  bool isSelected;
  final String text;

  @override
  State<ProductFilterItem> createState() => _ProductFilterItemState();
}

class _ProductFilterItemState extends State<ProductFilterItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          widget.isSelected = !widget.isSelected;
        });       
      },
      child: Card(
        // selected color
        color: widget.isSelected ? primary700 : primary300,
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
              color: widget.isSelected ? white : textPrimary,
              fontSize: 12.0,
              fontWeight: FontWeight.w400
            ),
          ),
        ),
      ),
    );
  }
}