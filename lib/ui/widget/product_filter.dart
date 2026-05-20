import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/widget/product_filter_condition.dart';
import 'package:finbrain/ui/widget/product_filter_item.dart';
import 'package:flutter/material.dart';

class ProductFilter extends StatefulWidget {
  const ProductFilter({
    super.key,
    required this.filters,
    required this.selectedFilters,
  });

  final Map<String, List<(String, bool)>> filters;
  final List<(String, bool)> selectedFilters;

  @override
  State<ProductFilter> createState() => _ProductFilterState();
}

class _ProductFilterState extends State<ProductFilter> {
  var isExpanded = false;
  
  @override
  Widget build(BuildContext context) {
    // todo: change number depending on the width of the screen
    final num = (widget.selectedFilters.length < 4) ? widget.selectedFilters.length : 4;
    
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
                  for (int i = 0; i < num; i++)
                    ProductFilterItem(
                      isSelected: widget.selectedFilters[i].$2,
                      text: widget.selectedFilters[i].$1,
                    ),
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
