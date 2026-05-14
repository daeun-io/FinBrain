import 'package:finbrain/provider/product_provider.dart';
import 'package:finbrain/ui/product_categories.dart';
import 'package:finbrain/ui/widget/filter_text.dart';
import 'package:finbrain/ui/widget/product_filter.dart';
import 'package:finbrain/ui/widget/product_item.dart';
import 'package:finbrain/ui/widget/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IsaMpScreen extends ConsumerWidget{
  const IsaMpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dummies = ref.read(productProvider);

    return Column(
      children: [
        const SizedBox(height: 16.0,),
        SearchBox(),
        const SizedBox(height: 16.0,),
        const ProductFilter(),
        const SizedBox(height: 24.0,),
        const FilterText(category: FilterTextCategory.isa,),
        const SizedBox(height: 20,),
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
      ],
    );
  }
}