import 'package:finbrain/data/models/entities/financial_product.dart';
import 'package:finbrain/data/viewModel/product_viewmodel.dart';
import 'package:finbrain/data/viewModel/sort_or_filter_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/widget/sort_or_filter.dart';
import 'package:finbrain/ui/widget/product_filter.dart';
import 'package:finbrain/ui/widget/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductBaseScreen extends ConsumerWidget {
  const ProductBaseScreen({
    super.key,
    required this.productCategory,
    required this.filterCategory,
  });

  final ProductCategory productCategory;
  final FilterTextCategory filterCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productViewmodelProvider);
    final textSort = ref.watch(
      sortOrFilterTextViewModelProvider(filterCategory),
    );
    products.when(
      data: (list) => print("🎉 진짜 성공해서 들어온 데이터 개수: ${list.length}"),
      error: (err, stack) => print("❌ 프로바이더 내부 에러: $err"),
      loading: () => print("⏳ 아직 서버에서 데이터 받아오는 중..."),
    );
    return Padding(
      padding: const EdgeInsets.only(
        top: 24.0,
        left: 20.0,
        right: 20.0,
        bottom: 20.0,
      ),
      child: Column(
        children: [
          ProductFilter(filterTextCategory: filterCategory),
          const SizedBox(height: 24.0),
          SortOrFilterText(
            category: filterCategory,
            onSortCriteriaChanged: (criteria) {
              ref
                  .read(productViewmodelProvider.notifier)
                  .sortByCriteria(criteria, productCategory);
            },
          ),
          const SizedBox(height: 12.0),
          products.when(
            data: (products) => Expanded(child: dataListView(products)),
            error: (err, stack) => Expanded(
              child: Center(
                child: Text(
                  "Error Occurred",
                  style: TextStyle(
                    color: black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            loading: () => Expanded(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }

  Widget dataListView(List<FinancialProduct> products) {
    if (products.isNotEmpty) {
      return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ProductItem(
              product: products[index],
              productCategory: productCategory,
              filterTextCategory: filterCategory,
            ),
          );
        },
      );
    } else {
      return const Text(
        "No Items",
        style: TextStyle(
          color: black,
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
        ),
      );
    }
  }
}
