import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/sort_or_filter_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/widget/sort_or_filter.dart';
import 'package:finbrain/ui/widget/product_filter.dart';
import 'package:finbrain/ui/widget/product_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductBaseScreen extends ConsumerStatefulWidget {
  const ProductBaseScreen({
    super.key,
    required this.productCategory,
    required this.filterCategory,
  });

  final ProductCategory productCategory;
  final FilterTextCategory filterCategory;

  @override
  ConsumerState<ProductBaseScreen> createState() => _ProductBaseScreenState();
}

class _ProductBaseScreenState extends ConsumerState<ProductBaseScreen> {
  final ScrollController _controller = ScrollController();
  final GlobalKey _centerKey = GlobalKey();
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
    if (position.pixels >= position.maxScrollExtent - 100) {
      final data = ref.read(productViewmodelProvider);
      if (data.hasValue && data.value != null) {
        _maxPage = data.value!.$1;
      }
      if (_cPage < _maxPage) {
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
        .fetchFinlifeProducts(widget.productCategory, _cPage.toString());
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
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

    // products.when(
    // data: (list) => print("🎉 진짜 성공해서 들어온 데이터 개수: ${list.$2.length}"),
    // error: (err, stack) => print("❌ 프로바이더 내부 에러: $err"),
    // loading: () => print("⏳ 아직 서버에서 데이터 받아오는 중..."),
    // );
    return Padding(
      padding: const EdgeInsets.only(
        top: 24.0,
        left: 20.0,
        right: 20.0,
        bottom: 20.0,
      ),
      child: Column(
        children: [
          ProductFilter(
            productCategory: widget.productCategory,
            filterTextCategory: widget.filterCategory,
          ),
          const SizedBox(height: 24.0),
          SortOrFilterText(
            category: widget.filterCategory,
            onSortCriteriaChanged: (criteria) {
              ref
                  .read(productViewmodelProvider.notifier)
                  .sortByCriteria(criteria, widget.productCategory, _maxPage);
            },
          ),
          const SizedBox(height: 12.0),
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
                            productCategory: widget.productCategory,
                            filterTextCategory: widget.filterCategory,
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
                            productCategory: widget.productCategory,
                            filterTextCategory: widget.filterCategory,
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
            loading: () => Center(
              child: const CircularProgressIndicator(color: primary500),
            ),
          ),
        ],
      ),
    );
  }
}
