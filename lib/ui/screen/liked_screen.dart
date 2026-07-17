import 'package:finbrain/ui/viewmodel/liked_product_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/selected_prdt_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/widget/ai_button.dart';
import 'package:finbrain/ui/widget/sort_or_filter.dart';
import 'package:finbrain/ui/widget/product_item.dart';
import 'package:finbrain/ui/widget/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikedScreen extends ConsumerWidget {
  const LikedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liked = ref.watch(likedProductViewmodelProvider);
    final selectedProducts = ref.watch(selectedProductsViewmodelProvider);
    final sProductsNm = selectedProducts
        .map((e) => e.commonInfo.productName)
        .whereType<String>()
        .join('`');

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
                  .read(likedProductViewmodelProvider.notifier)
                  .filterByKeyword(value);
            },
            fromLikedScreen: true,
          ),
          const SizedBox(height: 32.0),
          SortOrFilterText(
            category: ProductCategory.liked,
            baseYear: "",
            onSortCriteriaChanged: (criteria) {
              ref
                  .read(likedProductViewmodelProvider.notifier)
                  .filterByCategory(criteria);
            },
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: Stack(
              children: [
                if (liked.value != null)
                  Positioned.fill(
                    child: ListView.builder(
                      itemCount: liked.value!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: ProductItem(
                            companyName: liked.value![index].commonInfo.companyName!,
                            productName: liked.value![index].commonInfo.productName!,
                            category: liked.value![index].commonInfo.category,
                            fromLikedScreen: true,
                          ),
                        );
                      },
                    ),
                  ),
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: AiButton(
                    tag: "compare`$sProductsNm",
                    category: ProductCategory.liked,
                    isBtnClicked: (){},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
