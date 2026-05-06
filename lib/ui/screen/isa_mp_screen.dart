import 'package:finbrain/ui/widget/filter_text.dart';
import 'package:finbrain/ui/widget/product_filter.dart';
import 'package:finbrain/ui/widget/product_item.dart';
import 'package:finbrain/ui/widget/search_box.dart';
import 'package:flutter/material.dart';

class IsaMpScreen extends StatelessWidget{
  const IsaMpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16.0,),
        SearchBox(),
        const SizedBox(height: 16.0,),
        const ProductFilter(),
        const SizedBox(height: 24.0,),
        FilterText(),
        const SizedBox(height: 20,),
        Expanded(
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: ProductItem(),
              );
            },
          ),
        )
      ],
    );
  }
}