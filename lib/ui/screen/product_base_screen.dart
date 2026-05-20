import 'package:finbrain/provider/filters_provider.dart';
import 'package:finbrain/provider/product_provider.dart';
import 'package:finbrain/ui/product_categories.dart';
import 'package:finbrain/ui/widget/filter_text.dart';
import 'package:finbrain/ui/widget/product_filter.dart';
import 'package:finbrain/ui/widget/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductBaseScreen extends ConsumerWidget{
  const ProductBaseScreen({
    super.key,
    required this.productCategory,
    required this.filterCategory
  });

  final ProductBaseScreenCategory productCategory;
  final FilterTextCategory filterCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dummies = ref.watch(productProvider);
    final filters = ref.watch(filtersProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 20.0, right: 20.0, bottom: 20.0),
      child: Column(children: [
        ProductFilter(filters: filters,),
        const SizedBox(height: 24.0,),
        FilterText(category: filterCategory,),
        const SizedBox(height: 12.0),
        Expanded(
          child: ListView.builder(
            itemCount: dummies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ProductItem(
                  productName: dummies[index].commonInfo.productName!,
                ),
              );
            },
          ),
        )
      ],),
    );
  }
}