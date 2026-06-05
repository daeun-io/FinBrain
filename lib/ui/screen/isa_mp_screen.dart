import 'package:finbrain/provider/filter_text_provider.dart';
import 'package:finbrain/provider/filters_provider.dart';
import 'package:finbrain/provider/product_provider.dart';
import 'package:finbrain/provider/searched_provider.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/product_categories.dart';
import 'package:finbrain/ui/widget/filter_text.dart';
import 'package:finbrain/ui/widget/product_filter.dart';
import 'package:finbrain/ui/widget/product_item.dart';
import 'package:finbrain/ui/widget/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IsaMpScreen extends ConsumerWidget {
  const IsaMpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dummies = ref.watch(searchedProductProvider)(false);
    final searchedList = ref.watch(searchedListProvider);
    final filters = ref.watch(filtersNotifierProvider);
    final selectedFilters = ref.watch(selectedFilterProvider);
    final textFilter = ref.watch(FilterTextNotifierProvider(FilterTextCategory.isa));

    return Column(
      children: [
        const SizedBox(height: 16.0),
        SearchBox(
          searchItem: (value) {
            ref.read(searchQueryProvider.notifier).state = value;
            ref.read(searchedListProvider.notifier).addItem(value);
          },
          searchedList: searchedList,
        ),
        const SizedBox(height: 16.0),
        ProductFilter(filters: filters, selectedFilters: selectedFilters,),
        const SizedBox(height: 24.0),
        FilterText(category: FilterTextCategory.isa, onSortCriteriaChanged: (criteria){},),
        const SizedBox(height: 20),
        if(dummies.isEmpty)
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
              itemCount: dummies.length,
              itemBuilder: (context, index) {
                if(index >= dummies.length){
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ProductItem(
                    productName: dummies[index].commonInfo.productName!,
                    sortCriteria: textFilter.$1.toString(),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
