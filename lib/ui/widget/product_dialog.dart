import 'package:finbrain/ui/viewModel/filters_viewmodel.dart';
import 'package:finbrain/ui/viewModel/product_viewmodel.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/widget/custom_year_picker.dart';
import 'package:finbrain/ui/widget/product_filter_condition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDialog extends ConsumerWidget {
  const ProductDialog({
    super.key,
    required this.productCategory,
    required this.filterCategory,
  });
  final ProductCategory productCategory;
  final FilterTextCategory filterCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(dialogFiltersViewModelProvider(filterCategory));

    return Consumer(
      builder: (ctx, ref, child) {
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
                      onPressed: () {
                        ref
                            .read(
                              dialogFiltersViewModelProvider(
                                filterCategory,
                              ).notifier,
                            )
                            .resetChanges();
                      },
                      style: TextButton.styleFrom(
                        side: const BorderSide(color: textTertiary, width: 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(0.0),
                        ),
                        padding: EdgeInsets.all(4.0),
                        minimumSize: Size.zero,
                        overlayColor: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.refresh, color: textSecondary, size: 16.0),
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
                      ...filters.entries.map((e) {
                        if (e.key == "기준 연도") {
                          final filters = ref.read(
                            dialogFiltersViewModelProvider(filterCategory),
                          );
                          final year = (filters["기준 연도"] ?? []).first.$1;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8.0,),
                              const Text(
                                "기준 연도",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: textSecondary,
                                ),
                              ),
                              CustomYearPicker(
                                selectedYear:
                                    int.tryParse(year) ?? DateTime.now().year,
                                onYearChanged: (value) => ref
                                    .read(
                                      dialogFiltersViewModelProvider(
                                        filterCategory,
                                      ).notifier,
                                    )
                                    .toggleSelected(value.toString(), true),
                              ),
                              const SizedBox(height: 20.0,),
                            ],
                          );
                        } else {
                          return ProductFilterCondition(
                            category: filterCategory,
                            filter: e.key,
                            filterList: e.value,
                          );
                        }
                      }),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          final notifier = ref.read(
                            dialogFiltersViewModelProvider(
                              filterCategory,
                            ).notifier,
                          );
                          await notifier.applyChanges(productCategory, "1", filterCategory);
                          if (context.mounted) Navigator.pop(ctx);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: primary100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10.0),
                          ),
                          overlayColor: primary500,
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
  }
}
