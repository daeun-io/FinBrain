import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/widget/product_filter_condition.dart';
import 'package:finbrain/ui/widget/product_filter_item.dart';
import 'package:flutter/material.dart';

class ProductFilter extends StatefulWidget {
  const ProductFilter({super.key, required this.filters});

  final Map<String, List<(String, bool)>> filters;

  @override
  State<ProductFilter> createState() => _ProductFilterState();
}

class _ProductFilterState extends State<ProductFilter> {
  var isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: primary100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  // todo: change later
                  ProductFilterItem(isSelected: true, text: "테스트"),
                  ProductFilterItem(isSelected: true, text: "테스트"),
                  ProductFilterItem(isSelected: true, text: "테스트"),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (isExpanded) {
                          isExpanded = false;
                        } else {
                          isExpanded = true;
                        }
                      });
                    },
                    icon: isExpanded
                        ? const Icon(
                            Icons.arrow_drop_up,
                            color: primary700,
                            size: 32.0,
                          )
                        : const Icon(
                            Icons.arrow_drop_down_outlined,
                            color: primary700,
                            size: 32.0,
                          ),
                  ),
                ],
              ),
              if (isExpanded)
                ...widget.filters.entries.map((e) {
                  return ProductFilterCondition(
                    filter: e.key,
                    filterList: e.value,
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}
