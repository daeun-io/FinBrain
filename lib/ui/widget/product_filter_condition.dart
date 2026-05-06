import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/widget/product_filter_item.dart';
import 'package:flutter/material.dart';

class ProductFilterCondition extends StatelessWidget{
  const ProductFilterCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Text(
            "조건",
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: textPrimary,
            ),
          ),
          const SizedBox(width: 12,),
          // todo: change later
          const ProductFilterItem(),
          const ProductFilterItem(),
          const ProductFilterItem(),
        ],
      ),
    );
  }
}