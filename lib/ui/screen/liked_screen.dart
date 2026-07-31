import 'package:finbrain/ui/viewmodel/liked_product_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/selected_prdt_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/widget/ai_button.dart';
import 'package:finbrain/ui/widget/sort_or_filter.dart';
import 'package:finbrain/ui/widget/product_item.dart';
import 'package:finbrain/ui/widget/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 관심 상품 리스트
class LikedScreen extends ConsumerWidget {
  const LikedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 관심 상품 및 필터링 불러오기
    // Fetch liked products and their filter
    final liked = ref.watch(likedProductViewmodelProvider);
    final selectedProducts = ref.watch(selectedProductsViewmodelProvider);
    // 비교 분석 tag
    // AI Comparison response tag
    final prdtCodes = selectedProducts
        .map(
          (e) => (e.commonInfo.category == ProductCategory.isaMp)
              ? e.commonInfo.productName
              : e.commonInfo.productCode,
        )
        .whereType<String>()
        .join('`');
    // 비교 분석 name
    // AI Comparison response name
    final prdtNames = selectedProducts
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
          // 검색창(search bar)
          SearchBox(
            searchItem: (value) {
              ref
                  .read(likedProductViewmodelProvider.notifier)
                  .filterByKeyword(value);
            },
            fromLikedScreen: true,
          ),
          const SizedBox(height: 32.0),
          // 필터링 바텀시트(filter bottom sheet)
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
                            productCode:
                                liked.value![index].commonInfo.productCode ?? "isaMp",
                            productName:
                                liked.value![index].commonInfo.productName!,
                            category: liked.value![index].commonInfo.category,
                            fromLikedScreen: true,
                          ),
                        );
                      },
                    ),
                  ),
                // 비교 분석 AI 버튼
                // AI button for comparison
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: AiButton(
                    tag: "compare`$prdtCodes",
                    name: prdtNames,
                    category: ProductCategory.liked,
                    isBtnClicked: () {},
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
