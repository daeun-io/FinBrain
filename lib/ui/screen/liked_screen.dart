import 'package:finbrain/ui/screen/product_selection_screen.dart';
import 'package:finbrain/ui/viewmodel/liked_product_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/widget/ai_button.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/showing_error_widget.dart';
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
    // 관심 상품 관찰하기
    // Watch liked products
    final liked = ref.watch(likedProductViewmodelProvider);

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
          liked.when(
            data: (data) {
              return Expanded(
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
                                    data[index].commonInfo.productCode ??
                                    "isaMp",
                                productName:
                                    data[index].commonInfo.productName!,
                                category: data[index].commonInfo.category,
                                fromLikedScreen: true,
                                isSelecting: false,
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
                        tag: null,
                        name: null,
                        category: ProductCategory.liked,
                        isBtnClicked: () {
                          // 상품 선택 스크린으로 이동
                          // Navigate to product selection screen
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => const ProductSelectionScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => const Expanded(child: CustomProgressIndicator()),
            error: (error, stackTrace) =>
                const Expanded(child: ShowingErrorWidget()),
          ),
        ],
      ),
    );
  }
}
