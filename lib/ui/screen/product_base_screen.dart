import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewModel/product_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/current_page_viewmodel.dart';
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

  final ProductCategory category;

  @override
  ConsumerState<ProductBaseScreen> createState() => _ProductBaseScreenState();
}

class _ProductBaseScreenState extends ConsumerState<ProductBaseScreen> {
  final ScrollController _controller = ScrollController();
  final GlobalKey _key = GlobalKey();
  bool _isLoading = false;
  int _maxPage = 0;

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
    if (_isLoading) return;

    final cPage = ref.read(currentPageViewmodelProvider(widget.category));
    final position = _controller.position;
    if (position.pixels >= position.maxScrollExtent - 10) {
      if (cPage < _maxPage) {
        _isLoading = true;
        ref
            .read(currentPageViewmodelProvider(widget.category).notifier)
            .setCurrentPage(cPage + 1);
        _isLoading = false;
      } else {
        _isLoading = false;
      }
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

  // Future<void> _fetchData() async {
  //   final data = await ref.read(
  //     fetchProductViewmodelProvider(widget.category, "$_cPage").future,
  //   );
  //   if (data.$1 == -1) {
  //     _cPage++;
  //     final pData = await ref.read(
  //       fetchProductViewmodelProvider(widget.category, "$_cPage").future,
  //     );
  //     _maxPage = pData.$1;
  //   } else {
  //     _maxPage = data.$1;
  //   }
  //   ref
  //       .read(currentPageViewmodelProvider(widget.category).notifier)
  //       .setCurrentPage(_cPage);

  //   await Future.delayed(const Duration(seconds: 1));
  // }

  @override
  Widget build(BuildContext context) {
    final cPage = ref.watch(currentPageViewmodelProvider(widget.category));
    final productState = ref.watch(
      productViewmodelProvider(widget.category),
    );
    // ref.listen(savedFiltersProvider(widget.category), (prev, next) {
    //   if (prev != next) {
    //     // _fetchData();
    //     ref.invalidate(productViewmodelProvider(widget.category, "$_cPage"));
    //   }
    // });

    // Move to center after fetching data
    ref.listen(productViewmodelProvider(widget.category), (
      prev,
      next,
    ) {
      if (next.hasValue && prev?.value != next.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
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
              ProductFilter(category: widget.category),
              Expanded(
                child: SortOrFilterText(
                  category: widget.category,
                  baseYear: "",
                  onSortCriteriaChanged: (criteria) {
                    ref
                        .read(
                          productViewmodelProvider(
                            ProductCategory.isaMp,
                          ).notifier,
                        )
                        .sortByCriteria(criteria, widget.category, _maxPage);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          productState.when(
            data: (data) {
              final (maxPage, items) = data;
              _maxPage = maxPage;
              print("max page, $_maxPage");
              print("current page, $cPage");
              return Expanded(
                child: CustomScrollView(
                  controller: _controller,
                  center: _key,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    const SliverPadding(padding: EdgeInsets.only(top: 20.0)),
                    SliverPadding(key: _key, padding: EdgeInsets.zero),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
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
                    const SliverPadding(padding: EdgeInsets.only(bottom: 20.0)),
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
