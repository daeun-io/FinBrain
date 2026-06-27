import 'package:finbrain/data/viewModel/product_viewmodel.dart';
import 'package:finbrain/data/viewModel/searched_viewmodel.dart';
import 'package:finbrain/data/viewModel/sort_or_filter_viewmodel.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/product_categories.dart';
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
  final GlobalKey _centerKey = GlobalKey();
  bool _isLoading = false;
  int _cPage = 1;
  late int totalCount;

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
    if (position.pixels >= position.maxScrollExtent - 100) {
      final data = ref.read(productViewmodelProvider);
      if (data.hasValue && data.value != null) {
        totalCount = data.value!.$1;
      }
      final maxPage = totalCount ~/ (100 * _cPage) + 1;
      if (_cPage < maxPage) {
        setState(() {
          _isLoading = true;
          _cPage++;
        });
        print("_cPage: $_cPage");
        await _fetchData();
        setState(() {
          _isLoading = false;
        });
      }
    }
    if (position.pixels <= position.minScrollExtent + 100) {
      print("_cPage: $_cPage");
      if (_cPage > 1) {
        setState(() {
          _isLoading = true;
          _cPage--;
        });
        await _fetchData();
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _fetchData() async {
    ref
        .read(productViewmodelProvider.notifier)
        .fetchIsaMpProducts(_cPage.toString());
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final searchedList = ref.watch(searchedViewmodelProvider);
    final products = ref.watch(productViewmodelProvider);
    final textSort = ref.watch(
      sortOrFilterTextViewModelProvider(FilterTextCategory.isaMp),
    );

    // Move to center after fetching data
    ref.listen(productViewmodelProvider, (prev, next) {
      if (next.hasValue && prev?.value != next.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_controller.hasClients) {
            _controller.jumpTo(0);
          }
        });
      }
    });

    return Column(
      children: [
        const SizedBox(height: 16.0),
        SearchBox(
          searchItem: (value) {
            ref.read(productViewmodelProvider.notifier).filterByKeyword(value);
            ref.read(searchedViewmodelProvider.notifier).addItem(value);
          },
          searchedList: searchedList,
        ),
        const SizedBox(height: 16.0),
        ProductFilter(productCategory: ProductCategory.isa, filterTextCategory: FilterTextCategory.isaMp),
        const SizedBox(height: 24.0),
        SortOrFilterText(
          category: FilterTextCategory.isaMp,
          onSortCriteriaChanged: (criteria) {
            ref
                .read(productViewmodelProvider.notifier)
                .sortByCriteria(
                  criteria,
                  ProductCategory.isa,
                  products.value!.$1,
                );
          },
        ),
        const SizedBox(height: 20),
        products.when(
          data: (data) {
            final (maxPage, items) = data;
            final index = items.length ~/ 2;
            final prevItems = items.sublist(0, index);
            final nextItems = items.sublist(index);
            return Expanded(
              child: CustomScrollView(
                controller: _controller,
                center: _centerKey,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = prevItems[prevItems.length - 1 - index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: ProductItem(
                          product: item,
                          productCategory: ProductCategory.isa,
                          filterTextCategory: FilterTextCategory.isaMp,
                        ),
                      );
                    }, childCount: prevItems.length),
                  ),
                  SliverPadding(key: _centerKey, padding: EdgeInsets.zero),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = nextItems[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: ProductItem(
                          product: item,
                          productCategory: ProductCategory.isa,
                          filterTextCategory: FilterTextCategory.isaMp,
                        ),
                      );
                    }, childCount: nextItems.length),
                  ),
                ],
              ),
            );
          },
          error: (err, stack) => Expanded(
            child: Center(
              child: Text(
                "오류가 발생했습니다. 다시 시도해주세요",
                style: TextStyle(
                  color: black,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          loading: () =>
              Center(child: const CircularProgressIndicator(color: primary500)),
        ),
      ],
    );
  }
}
