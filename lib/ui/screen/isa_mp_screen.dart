import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewModel/filters_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/sort_or_filter_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/showing_error_widget.dart';
import 'package:finbrain/ui/widget/sort_or_filter.dart';
import 'package:finbrain/ui/widget/product_filter.dart';
import 'package:finbrain/ui/widget/product_item.dart';
import 'package:finbrain/ui/widget/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ISA 일임형 상품 스크린
// ISA mp product screen
class IsaMpScreen extends ConsumerStatefulWidget {
  const IsaMpScreen({super.key});

  @override
  ConsumerState<IsaMpScreen> createState() => _IsaMpScreenState();
}

class _IsaMpScreenState extends ConsumerState<IsaMpScreen> {
  @override
  Widget build(BuildContext context) {
    // 현재 페이지, ISA 상품 상태, 필터 관찰하기
    // Watch current page, ISA products status and their filter
    final products = ref.watch(productViewmodelProvider(ProductCategory.isaMp));
    final filters = ref.watch(filtersViewmodelProvider(ProductCategory.isaMp));

    final baseYear =
        filters
            .whenData(
              (data) => data["기준년도"]!.firstWhere((e) => e.$2 == true).$1,
            )
            .value ??
        "";

    return Column(
      children: [
        const SizedBox(height: 24.0),
        // 검색창(search bar)
        SearchBox(
          searchItem: (value) {
            ref
                .read(productViewmodelProvider(ProductCategory.isaMp).notifier)
                .filterByKeyword(value);
          },
        ),
        const SizedBox(height: 24.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 필터 버튼(filter button)
            ProductFilter(category: ProductCategory.isaMp),
            // 정렬 바텀시트(sorting bottom sheet)
            Expanded(
              child: SortOrFilterText(
                category: ProductCategory.isaMp,
                baseYear: baseYear,
                onSortCriteriaChanged: (criteria) {
                  ref
                      .read(
                        sortOrFilterTextViewModelProvider(
                          ProductCategory.isaMp,
                        ).notifier,
                      )
                      .changeCriteria(criteria);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 24.0),
        products.when(
          data: (data) {
            // 최대 페이지 불러와 최대 페이지 계산
            // Fetch total count and calculate maximum page
            return Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ProductItem(
                    productCode: data[index].commonInfo.productCode ?? "ISA_MP",
                    productName: data[index].commonInfo.productName!,
                    category: data[index].commonInfo.category,
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
    );
  }
}
