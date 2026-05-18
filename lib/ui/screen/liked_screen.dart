import 'package:finbrain/provider/searched_provider.dart';
import 'package:finbrain/ui/product_categories.dart';
import 'package:finbrain/ui/widget/ai_button.dart';
import 'package:finbrain/ui/widget/filter_text.dart';
import 'package:finbrain/ui/widget/product_filter.dart';
import 'package:finbrain/ui/widget/product_item.dart';
import 'package:finbrain/ui/widget/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikedScreen extends ConsumerWidget {
  const LikedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likedDummies = ref.watch(searchedProductProvider)(true);
    final searchedList = ref.watch(searchedListProvider);

    return Padding(
      padding: const EdgeInsets.only(
        top: 24.0,
        left: 20.0,
        right: 20.0,
        bottom: 20.0,
      ),
      child: Column(
        children: [
          SearchBox(
            searchItem: (value) {
              ref.read(searchQueryProvider.notifier).state = value;
              ref.read(searchedListProvider.notifier).addItem(value);
            },
            searchedList: searchedList,
          ),
          const SizedBox(height: 16.0),
          const ProductFilter(),
          const SizedBox(height: 24.0),
          const FilterText(category: FilterTextCategory.liked),
          const SizedBox(height: 20.0),
          Expanded(
            child: Stack(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: likedDummies.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: ProductItem(
                          productName:
                              likedDummies[index].commonInfo.productName!,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(right: 0, bottom: 0, child: const AiButton()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
