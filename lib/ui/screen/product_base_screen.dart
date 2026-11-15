import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/sort_or_filter_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/search_box.dart';
import 'package:finbrain/ui/widget/showing_error_widget.dart';
import 'package:finbrain/ui/widget/sort_or_filter.dart';
import 'package:finbrain/ui/widget/product_filter.dart';
import 'package:finbrain/ui/widget/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductBaseScreen extends ConsumerStatefulWidget {
  const ProductBaseScreen({super.key, required this.category});

  final ProductCategory category; // 상품 카테고리(product category)

  @override
  ConsumerState<ProductBaseScreen> createState() => _ProductBaseScreenState();
}

class _ProductBaseScreenState extends ConsumerState<ProductBaseScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 현재 페이지와 상품 상태 관찰하기
    // Watch current page and product state
    //final cPage = ref.watch(currentPageViewmodelProvider(widget.category));
    final productState = ref.watch(productViewmodelProvider(widget.category));

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
                  .read(productViewmodelProvider(widget.category).notifier)
                  .filterByKeyword(value);
            },
          ),
          const SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 필터 버튼(filter button)
              ProductFilter(category: widget.category),
              // 정렬 바텀시트(sorting bottom sheet)
              Expanded(
                child: SortOrFilterText(
                  category: widget.category,
                  baseYear: "",
                  onSortCriteriaChanged: (criteria) {
                    ref
                        .read(
                          sortOrFilterTextViewModelProvider(
                            widget.category,
                          ).notifier,
                        )
                        .changeCriteria(criteria);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          productState.when(
            data: (data) {
              final (maxPage, items) = data;
              return Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ProductItem(
                      productCode: items[index].commonInfo.productCode!,
                      productName: items[index].commonInfo.productName!,
                      category: items[index].commonInfo.category,
                      fromLikedScreen: false,
                      isSelecting: false,
                    ),
                  ),
                ),
              );
            },
            error: (err, stack) => const Expanded(child: ShowingErrorWidget()),
            loading: () => const Expanded(child: CustomProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
