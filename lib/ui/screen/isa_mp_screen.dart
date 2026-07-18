import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewModel/filters_viewmodel.dart';
import 'package:finbrain/ui/viewModel/product_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/current_page_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/no_data_found.dart';
import 'package:finbrain/ui/widget/showing_error_widget.dart';
import 'package:finbrain/ui/widget/sort_or_filter.dart';
import 'package:finbrain/ui/widget/product_filter.dart';
import 'package:finbrain/ui/widget/product_item.dart';
import 'package:finbrain/ui/widget/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IsaMpScreen extends ConsumerStatefulWidget {
  const IsaMpScreen({super.key});

  @override
  ConsumerState<IsaMpScreen> createState() => _IsaMpScreenState();
}

class _IsaMpScreenState extends ConsumerState<IsaMpScreen> {
  final ScrollController _controller = ScrollController();
  final GlobalKey _key = GlobalKey();
  bool _isLoading = false;
  //late int _cPage;
  // int _totalCount = 0;
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

    final cPage = ref.read(currentPageViewmodelProvider(ProductCategory.isaMp));
    final position = _controller.position;
    if (position.pixels >= position.maxScrollExtent - 10) {
      if (cPage < _maxPage) {
        _isLoading = true;
        ref
            .read(currentPageViewmodelProvider(ProductCategory.isaMp).notifier)
            .setCurrentPage(cPage + 1);
        _isLoading = false;
      } else {
        _isLoading = false;
      }
    } else if (position.pixels <= position.minScrollExtent + 10) {
      if (cPage > 1) {
        _isLoading = true;
        ref
            .read(currentPageViewmodelProvider(ProductCategory.isaMp).notifier)
            .setCurrentPage(cPage - 1);
        _isLoading = false;
      } else {
        _isLoading = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cPage = ref.watch(
      currentPageViewmodelProvider(ProductCategory.isaMp),
    );
    final products = ref.watch(productViewmodelProvider(ProductCategory.isaMp));
    final filters = ref.watch(filtersViewmodelProvider(ProductCategory.isaMp));

    // Move to center after fetching data
    ref.listen(productViewmodelProvider(ProductCategory.isaMp), (prev, next) {
      if (next.hasValue && prev?.value != next.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_controller.hasClients) {
            _controller.jumpTo(0);
          }
        });
      }
    });

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
        SearchBox(
          searchItem: (value) {
            ref
                .read(productViewmodelProvider(ProductCategory.isaMp).notifier)
                .filterByKeyword(value);
          },
          fromLikedScreen: false,
        ),
        const SizedBox(height: 24.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProductFilter(category: ProductCategory.isaMp),
            Expanded(
              child: SortOrFilterText(
                category: ProductCategory.isaMp,
                baseYear: baseYear,
                onSortCriteriaChanged: (criteria) {
                  ref
                      .read(
                        productViewmodelProvider(
                          ProductCategory.isaMp,
                        ).notifier,
                      )
                      .sortByCriteria(
                        criteria,
                        ProductCategory.isaMp,
                        products.value!.$1,
                      );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 24.0),
        products.when(
          data: (data) {
            final (totalCount, items) = data;
            _maxPage = (totalCount == 0) ? 1 : (totalCount - 1) ~/ 100 + 1;
            print("max page in isa mp, $_maxPage");
            print("current page in isa mp, $cPage");
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
                      if (items.isEmpty) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.45,
                          alignment: Alignment.center,
                          child: NoDataFound(
                            ctg: ProductCategory.isaMp,
                            isProduct: true,
                            isLastPage: (cPage == _maxPage),
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: ProductItem(
                          productCode:
                              items[index].commonInfo.productCode ?? "isaMp",
                          productName: items[index].commonInfo.productName!,
                          category: items[index].commonInfo.category,
                          fromLikedScreen: false,
                        ),
                      );
                    }, childCount: items.length),
                  ),
                  SliverPadding(padding: EdgeInsets.only(top: 20.0)),
                ],
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
