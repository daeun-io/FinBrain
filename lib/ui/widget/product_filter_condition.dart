import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/widget/product_filter_item.dart';
import 'package:flutter/material.dart';

class ProductFilterCondition extends StatelessWidget {
  const ProductFilterCondition({
    super.key,
    required this.filter,
    required this.filterList,
  });

  final String filter;
  final List<(String, bool)> filterList;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          filter,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            color: textPrimary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var item in filterList)
                  ProductFilterItem(
                    isSelected: item.$2, 
                    text: item.$1,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
