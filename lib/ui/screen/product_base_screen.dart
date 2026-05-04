import 'package:finbrain/ui/widget/product_filter.dart';
import 'package:finbrain/ui/widget/product_item.dart';
import 'package:flutter/material.dart';

class ProductBaseScreen extends StatelessWidget{
  const ProductBaseScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 20.0, right: 20.0, bottom: 20.0),
      child: Column(children: [
        const ProductFilter(),
        const SizedBox(height: 24.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              "정렬 기준", 
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400
              ),
            ),
            IconButton(
              // todo: implement later
              onPressed: (){},
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              visualDensity: VisualDensity.compact,
              icon: Icon(Icons.keyboard_arrow_down, size: 24,)
            )
          ],
        ),
        const SizedBox(height: 12.0),
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
      ],),
    );
  }
}