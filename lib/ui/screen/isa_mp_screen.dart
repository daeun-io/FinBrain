import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
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
    if (position.pixels > position.maxScrollExtent) {
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
        await _fetchData();
        setState(() {
          _isLoading = false;
        });
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
    final colorScheme = Theme.of(context).colorScheme;
    final products = ref.watch(productViewmodelProvider);

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
        const SizedBox(height: 24.0),
        SearchBox(
          searchItem: (value) {
            ref.read(productViewmodelProvider.notifier).filterByKeyword(value);
          },
        ),
        const SizedBox(height: 24.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProductFilter(category: ProductCategory.isaMp),
            Expanded(
              child: SortOrFilterText(
                category: ProductCategory.isaMp,
                onSortCriteriaChanged: (criteria) {
                  ref
                      .read(productViewmodelProvider.notifier)
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
    );
  }
}
