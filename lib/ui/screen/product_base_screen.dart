import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewmodel/current_page_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/sort_or_filter_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/no_data_found.dart';
import 'package:finbrain/ui/widget/search_box.dart';
import 'package:finbrain/ui/widget/showing_error_widget.dart';
import 'package:finbrain/ui/widget/sort_or_filter.dart';
import 'package:finbrain/ui/widget/product_filter.dart';
import 'package:finbrain/ui/widget/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductBaseScreen extends ConsumerStatefulWidget {
  const ProductBaseScreen({super.key, required this.category});

  final ProductCategory category;       // 상품 카테고리(product category)

  @override
  ConsumerState<ProductBaseScreen> createState() => _ProductBaseScreenState();
}

class _ProductBaseScreenState extends ConsumerState<ProductBaseScreen> {
  final ScrollController _controller = ScrollController();
  final GlobalKey _key = GlobalKey();
  bool _isLoading = false;            // 데이터 로딩 여부(loading data state)
  int _maxPage = 0;                   // API 데이터 최대 페이지(api data max page)
  
  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() async {
    // 데이터 로딩 중이면 함수 중단
    // Stop calling function when data is loading
    if (_isLoading || !_controller.hasClients) return;
    // 현재 페이지 불러오기
    // Fetch current page
    final cPage = ref.read(currentPageViewmodelProvider(widget.category));
    final position = _controller.position;

    if (position.maxScrollExtent <= 0) return;
    final productAsync = ref.read(productViewmodelProvider(widget.category));
    if (productAsync.isLoading) return;
    
    // 최하단 스크롤 위치에 도달하면 다음 페이지 불러오기
    // Fetch next page when reached bottom of the list
    if (position.pixels >= position.maxScrollExtent) {
      if (cPage < _maxPage) {
        _isLoading = true;
        ref
            .read(currentPageViewmodelProvider(widget.category).notifier)
            .setCurrentPage(cPage + 1);
        _isLoading = false;
      } else {
        _isLoading = false;
      }
    // 최상단 위치에 도달하면 다음 페이지 불러오기
    // Fetch previous page when reached top of the list
    } else if (position.pixels <= position.minScrollExtent + 10) {
      if (cPage > 1) {
        _isLoading = true;
        ref
            .read(currentPageViewmodelProvider(widget.category).notifier)
            .setCurrentPage(cPage - 1);
        _isLoading = false;
      } else {
        _isLoading = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 현재 페이지와 상품 상태 관찰하기
    // Watch current page and product state
    final cPage = ref.watch(currentPageViewmodelProvider(widget.category));
    final productState = ref.watch(
      productViewmodelProvider(widget.category),
    );

    // 데이터 불러오면 상단으로 이동
    // Move to top after fetching data
    ref.listen(fetchProductViewmodelProvider(widget.category, cPage), (
      prev,
      next,
    ) {
      if (next.hasValue && prev?.value != next.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // 최대 페이지 불러오기
          // Fetch maximum page
          final (maxPage, _) = next.value!;
          _maxPage = maxPage;
          if (_controller.hasClients) {
            _controller.jumpTo(0);
          }
        });
      }
    });

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
                  .read(
                    productViewmodelProvider(
                      widget.category,
                    ).notifier,
                  )
                  .filterByKeyword(value);
            },
            fromLikedScreen: false,
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
                    ref.read(sortOrFilterTextViewModelProvider(widget.category).notifier).changeCriteria(criteria);
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
                key: ValueKey("${productState.hashCode}"),
                child: CustomScrollView(
                  controller: _controller,
                  center: _key,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    const SliverPadding(padding: EdgeInsets.only(top: 20.0)),
                    SliverPadding(key: _key, padding: EdgeInsets.zero),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        // 데이터 없을 때 스크린
                        // Screen when no data
                        if (items.isEmpty) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.45,
                            alignment: Alignment.center,
                            child: NoDataFound(
                              ctg: widget.category,
                              isProduct: true,
                              isLastPage: (cPage == maxPage),
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: ProductItem(
                            key: ValueKey(items[index].commonInfo.productCode!),
                            productCode: items[index].commonInfo.productCode!,
                            productName: items[index].commonInfo.productName!,
                            category: items[index].commonInfo.category,
                            fromLikedScreen: false,
                          ),
                        );
                      }, childCount: items.isEmpty ? 1 : items.length),
                    ),
                    const SliverPadding(padding: EdgeInsets.only(bottom: 60.0)),
                  ],
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
