import 'package:finbrain/themes/colors.dart';
import 'package:flutter/material.dart';

class ProductFilterItem extends StatelessWidget{
  const ProductFilterItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      // selected color
      color: primary700,
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
          "하나은행",
          style: TextStyle(
            color: white,
            fontSize: 12.0,
            fontWeight: FontWeight.w400
          ),
        ),
      ),
    );
  }
}