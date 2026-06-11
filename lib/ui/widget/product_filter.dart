import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/widget/product_filter_condition.dart';
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
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () {
        setState(() {
          showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                backgroundColor: white,
                contentPadding: const EdgeInsets.only(
                  top: 20.0,
                  left: 20.0,
                  right: 20.0,
                  bottom: 16.0,
                ),
                content: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.tune, color: primary900, size: 24.0),
                          const Text(
                            "필터",
                            style: TextStyle(
                              color: primary900,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              side: const BorderSide(
                                color: textTertiary,
                                width: 1.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(
                                  0.0,
                                ),
                              ),
                              padding: EdgeInsets.all(4.0),
                              minimumSize: Size.zero,
                              overlayColor: Colors.transparent,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.refresh,
                                  color: textSecondary,
                                  size: 16.0,
                                ),
                                Text(
                                  "초기화",
                                  style: TextStyle(
                                    color: textSecondary,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Flexible(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            ...widget.filters.entries.map(
                              (e) => ProductFilterCondition(
                                filter: e.key,
                                filterList: e.value,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(ctx, widget.filters);
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: primary100,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    10.0,
                                  ),
                                ),
                                overlayColor: primary500
                              ),
                              child: Text(
                                "필터 적용",
                                style: TextStyle(
                                  color: textPrimary,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: primary100,
        ),
        margin: EdgeInsets.zero,
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          children: const [
            Icon(Icons.tune, color: primary900, size: 24.0),
            Text(
              "필터",
              style: TextStyle(
                color: primary900,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
