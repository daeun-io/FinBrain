import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewModel/current_page_viewmodel.dart';
import 'package:finbrain/ui/viewModel/product_viewmodel.dart';
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

  final ProductCategory category;

  @override
  ConsumerState<ProductBaseScreen> createState() => _ProductBaseScreenState();
}

class _ProductBaseScreenState extends ConsumerState<ProductBaseScreen> {
  final ScrollController _controller = ScrollController();
  final GlobalKey _key = GlobalKey();
  bool _isLoading = false;
  int _cPage = 1;
  int _maxPage = 1;

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
    final position = _controller.position;
    if (position.pixels > position.maxScrollExtent) {
      final data = ref.read(
        productViewmodelProvider(widget.category, "$_cPage"),
      );
      if (data.hasValue && data.value != null) {
        _maxPage = data.value!.$1;
      }
      if (_cPage < _maxPage) {
        setState(() {
          _isLoading = true;
          _cPage++;
        });
        await _fetchData();
        setState(() {
          _isLoading = false;
        });
        ref
            .read(currentPageViewmodelProvider(widget.category).notifier)
            .setCurrentPage(_cPage);
      }
    }
    if (position.pixels < position.minScrollExtent) {
      if (_cPage > 1) {
        setState(() {
          _isLoading = true;
          _cPage--;
        });
        await _fetchData();
        setState(() {
          _isLoading = false;
        });
        ref
            .read(currentPageViewmodelProvider(widget.category).notifier)
            .setCurrentPage(_cPage);
      }
    }
  }

  Future<void> _fetchData() async {
    ref.read(fetchProductViewmodelProvider(widget.category, "$_cPage"));
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final products = ref.watch(
      productViewmodelProvider(widget.category, "$_cPage"),
    );

    // Move to center after fetching data
    ref.listen(productViewmodelProvider(widget.category, "$_cPage"), (
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
                      "$_cPage",
                    ).notifier,
                  )
                  .filterByKeyword(value);
            },
          ),
          const SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProductFilter(category: widget.category),
              Expanded(
                child: SortOrFilterText(
                  category: widget.category,
                  onSortCriteriaChanged: (criteria) {
                    ref
                        .read(
                          productViewmodelProvider(
                            ProductCategory.isaMp,
                            "$_cPage",
                          ).notifier,
                        )
                        .sortByCriteria(criteria, widget.category, _maxPage);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          products.when(
            data: (data) {
              if (data.$2.isEmpty) {
                return Center(
                  child: Text(
                    "상품이 존재하지 않습니다",
                    style: textTheme.bodyMedium!.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                );
              }
              final (maxPage, items) = data;
              return Expanded(
                child: CustomScrollView(
                  controller: _controller,
                  center: _key,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverPadding(padding: EdgeInsets.only(top: 20.0)),
                    SliverPadding(key: _key, padding: EdgeInsets.zero),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: ProductItem(
                            product: items[index],
                            fromLikedScreen: false,
                          ),
                        );
                      }, childCount: items.length),
                    ),
                  ],
                ),
              );
            },
            error: (err, stack) => const ShowingErrorWidget(),
            loading: () => const CustomProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
