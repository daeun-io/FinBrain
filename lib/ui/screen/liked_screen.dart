import 'package:finbrain/ui/widget/ai_button.dart';
import 'package:finbrain/ui/widget/filter_text.dart';
import 'package:finbrain/ui/widget/product_filter.dart';
import 'package:finbrain/ui/widget/product_item.dart';
import 'package:finbrain/ui/widget/search_box.dart';
import 'package:flutter/material.dart';

class LikedScreen extends StatelessWidget{
  const LikedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 20.0, right: 20.0, bottom: 20.0),
      child: Column(
        children: [
          SearchBox(),
          const SizedBox(height: 16.0,),
          ProductFilter(),
          const SizedBox(height: 24.0,),
          FilterText(),
          const SizedBox(height: 20.0,),
          Expanded(
            child: Stack(
              children: [
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
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: AiButton()
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}