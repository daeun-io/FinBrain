import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/widget/product_dialog.dart';
import 'package:flutter/material.dart';

class ProductFilter extends StatefulWidget {
  const ProductFilter({super.key, required this.category});

  final FilterTextCategory category;

  @override
  State<ProductFilter> createState() => _ProductFilterState();
}

class _ProductFilterState extends State<ProductFilter> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () {
        setState(() {
          showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return ProductDialog(filterCategory: widget.category,);
            },
          );
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: primary100,
        ),
        margin: EdgeInsets.zero,
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          children: const [
            Icon(Icons.tune, color: primary900, size: 24.0),
            Text(
              "필터",
              style: TextStyle(
                color: primary900,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
