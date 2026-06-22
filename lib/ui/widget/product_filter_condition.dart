import 'package:finbrain/product_categories.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/widget/product_filter_item.dart';
import 'package:flutter/material.dart';

class ProductFilterCondition extends StatelessWidget {
  const ProductFilterCondition({
    super.key,
    required this.category,
    required this.filter,
    required this.filterList,
  });

  final FilterTextCategory category;
  final String filter;
  final List<(String, bool)> filterList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          filter,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            color: textSecondary,
          ),
        ),
        const SizedBox(height: 8.0),
        if (filter == "회사 선택") ...[
          const Text(
            "* 미선택 시 전부 해당됩니다",
            style: TextStyle(
              fontSize: 10.0,
              color: textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8.0),
        ],
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          alignment: WrapAlignment.start,
          children: [
            ...filterList.map(
              (e) => ProductFilterItem(category: category, isSelected: e.$2, text: e.$1),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
      ],
    );
  }
}
