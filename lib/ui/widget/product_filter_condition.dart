import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/widget/product_filter_item.dart';
import 'package:flutter/material.dart';

// 필터 다이얼로그 속 필터 조건
// Filter condition in dialog
class ProductFilterCondition extends StatelessWidget {
  const ProductFilterCondition({
    super.key,
    required this.category,
    required this.filter,
    required this.filterList,
  });

  final ProductCategory category;
  final String filter;
  final List<(String, bool)> filterList;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          filter,
          style: textTheme.bodyMedium!.copyWith(color: colorScheme.onTertiary)
        ),
        const SizedBox(height: 8.0),
        if (filter == "회사 선택") ...[
          Text(
            "* 미선택 시 전부 해당됩니다",
            style: textTheme.bodySmall!.copyWith(color: colorScheme.onPrimary)
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
