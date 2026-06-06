import 'package:finbrain/provider/searched_provider.dart';
import 'package:finbrain/ui/product_categories.dart';
import 'package:finbrain/ui/widget/ai_button.dart';
import 'package:finbrain/ui/widget/filter_text.dart';
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
          const SizedBox(height: 24.0),
          FilterText(category: FilterTextCategory.liked, onSortCriteriaChanged: (criteria){},),
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
                          sortCriteria: switch(likedDummies[index].commonInfo.category){
                            ProductCategory.deposit => "최고 금리(높은순)",
                            ProductCategory.installment => "최고 금리(높은순)",
                            ProductCategory.annuity => "평균 수익률(높은 순)",
                            _ => "최저 금리(낮은 순)"
                          },
                        ),
                      );
                    },
                  ),
                ),
                Positioned(right: 5, bottom: 5, child: const AiButton()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
