import 'package:finbrain/data/viewModel/product_viewmodel.dart';
import 'package:finbrain/data/viewModel/searched_viewmodel.dart';
import 'package:finbrain/data/viewModel/sort_or_filter_viewmodel.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/widget/sort_or_filter.dart';
import 'package:finbrain/ui/widget/product_filter.dart';
import 'package:finbrain/ui/widget/product_item.dart';
import 'package:finbrain/ui/widget/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IsaMpScreen extends ConsumerWidget {
  const IsaMpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchedList = ref.watch(searchedViewmodelProvider);
    final products = ref.watch(productViewmodelProvider);
    final textSort = ref.watch(
      sortOrFilterTextViewModelProvider(FilterTextCategory.isaMp),
    );

    return Column(
      children: [
        const SizedBox(height: 16.0),
        SearchBox(
          searchItem: (value) {
            ref
                .read(productViewmodelProvider.notifier)
                .filterByKeyword(value);
            ref.read(searchedViewmodelProvider.notifier).addItem(value);
          },
          searchedList: searchedList,
        ),
        const SizedBox(height: 16.0),
        ProductFilter(category: FilterTextCategory.isaMp),
        const SizedBox(height: 24.0),
        SortOrFilterText(
          category: FilterTextCategory.isaMp,
          onSortCriteriaChanged: (criteria) {
            ref
                .read(productViewmodelProvider.notifier)
                .sortByCriteria(criteria, ProductCategory.isa);
          },
        ),
        const SizedBox(height: 20),
        if (products.valueOrNull == null && products.value!.isEmpty)
          Expanded(
            child: Center(
              child: Text(
                "찾고자하는 상품이 없습니다",
                style: TextStyle(
                  color: textPrimary,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: products.value!.length,
              itemBuilder: (context, index) {
                if (index >= products.value!.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ProductItem(
                    product: products.value![index],
                    productCategory: ProductCategory.isa,
                    filterTextCategory: FilterTextCategory.isaMp,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
