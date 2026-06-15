import 'package:finbrain/data/viewModel/product_viewmodel.dart';
import 'package:finbrain/data/viewModel/sort_or_filter_viewmodel.dart';
import 'package:finbrain/ui/product_categories.dart';
import 'package:finbrain/ui/widget/sort_or_filter.dart';
import 'package:finbrain/ui/widget/product_filter.dart';
import 'package:finbrain/ui/widget/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductBaseScreen extends ConsumerWidget {
  const ProductBaseScreen({
    super.key,
    required this.productCategory,
    required this.filterCategory,
  });

  final ProductCategory productCategory;
  final FilterTextCategory filterCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productViewmodelProvider);
    final textSort = ref.watch(
      sortOrFilterTextViewModelProvider(filterCategory),
    );

    return Padding(
      padding: const EdgeInsets.only(
        top: 24.0,
        left: 20.0,
        right: 20.0,
        bottom: 20.0,
      ),
      child: Column(
        children: [
          ProductFilter(category: productCategory),
          const SizedBox(height: 24.0),
          SortOrFilterText(
            category: filterCategory,
            onSortCriteriaChanged: (criteria) {
              ref
                  .read(productViewmodelProvider.notifier)
                  .sortByCriteria(criteria, productCategory);
            },
          ),
          const SizedBox(height: 12.0),
          if (products.valueOrNull != null)
            Expanded(
              child: ListView.builder(
                itemCount: products.value!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ProductItem(
                      productName: products.value![index].commonInfo.productName!,
                      filterTextCategory: filterCategory,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
