import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/widget/product_filter_condition.dart';
import 'package:finbrain/ui/widget/product_filter_item.dart';
import 'package:flutter/material.dart';

class ProductFilter extends StatefulWidget{
  const ProductFilter({super.key});

  @override
  State<ProductFilter> createState() => _ProductFilterState();
}

class _ProductFilterState extends State<ProductFilter> {
  var isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: primary100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
          child: Column(
            children: [
              Row(
                  children: [
                    // todo: change later
                    const ProductFilterItem(),
                    const ProductFilterItem(),
                    const ProductFilterItem(),
                    const Spacer(),
                    IconButton(
                      onPressed: (){
                        setState(() {
                          if(isExpanded){
                            isExpanded = false;
                          }else{
                            isExpanded = true;
                          }
                        });
                      },
                      icon: isExpanded ? const Icon(Icons.arrow_drop_up, color: primary700, size: 32.0,) : const Icon(Icons.arrow_drop_down_outlined, color: primary700, size: 32.0,)
                    )
                  ]
                ),
                if(isExpanded)
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      // change later
                      itemCount: 2,
                      itemBuilder: (context, index){
                        return ProductFilterCondition();
                      }
                    ),
                  ),
              ],
            ),
        )
        );
  }
}