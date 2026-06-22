import 'package:finbrain/data/viewModel/product_viewmodel.dart';
import 'package:finbrain/data/viewModel/searched_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/widget/ai_button.dart';
import 'package:finbrain/ui/widget/sort_or_filter.dart';
import 'package:finbrain/ui/widget/product_item.dart';
import 'package:finbrain/ui/widget/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikedScreen extends ConsumerWidget {
  const LikedScreen({super.key});

  // todo: change later
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = likedProductViewmodelProvider(
      ProductCategory.deposit,
      FilterTextCategory.savings,
      "020000",
      "1",
      "",
      "",
      "",
      "",
      ""
    );
    final likedDummies = ref.watch(provider);
    final searchedList = ref.watch(searchedViewmodelProvider);

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
              ref
                  .read(provider.notifier)
                  .filterByKeyword(value);
              ref.read(searchedViewmodelProvider.notifier).addItem(value);
            },
            searchedList: searchedList,
          ),
          const SizedBox(height: 24.0),
          SortOrFilterText(
            category: FilterTextCategory.liked,
            onSortCriteriaChanged: (criteria) {},
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: Stack(
              children: [
                if (likedDummies.valueOrNull != null)
                  Expanded(
                    child: ListView.builder(
                      itemCount: likedDummies.value!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: ProductItem(
                            productName: likedDummies
                                .value![index]
                                .commonInfo
                                .productName!,
                            productCategory: likedDummies.value![index].commonInfo.category,
                            filterTextCategory: FilterTextCategory.liked,
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
