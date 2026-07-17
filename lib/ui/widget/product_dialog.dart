import 'package:finbrain/ui/viewmodel/filters_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/custom_year_picker.dart';
import 'package:finbrain/ui/widget/product_filter_condition.dart';
import 'package:finbrain/ui/widget/showing_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDialog extends ConsumerWidget {
  const ProductDialog({super.key, required this.category});
  final ProductCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final filters = ref.watch(dialogFiltersViewModelProvider(category));

    return Consumer(
      builder: (ctx, ref, child) {
        return AlertDialog(
          backgroundColor: colorScheme.surfaceContainer,
          contentPadding: const EdgeInsets.only(
            top: 20.0,
            left: 20.0,
            right: 20.0,
            bottom: 16.0,
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.65,
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.tune, color: colorScheme.onPrimary, size: 24.0),
                    const SizedBox(width: 4.0,),
                    Text(
                      "필터",
                      style: textTheme.headlineMedium!.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        ref
                            .read(
                              dialogFiltersViewModelProvider(category).notifier,
                            )
                            .resetChanges();
                      },
                      style: TextButton.styleFrom(
                        side: BorderSide(
                          color: colorScheme.onTertiary,
                          width: 1.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(0.0),
                        ),
                        padding: EdgeInsets.all(4.0),
                        minimumSize: Size.zero,
                        overlayColor: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.refresh,
                            color: colorScheme.onTertiary,
                            size: 16.0,
                          ),
                          Text(
                            "초기화",
                            style: textTheme.bodySmall!.copyWith(
                              color: colorScheme.onTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                filters.when(
                  data: (data) {
                    if (data.isEmpty) {
                      return Expanded(child: const CustomProgressIndicator());
                    } else {
                      return Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (category == ProductCategory.isaJoin ||
                                  category == ProductCategory.isaManagement ||
                                  category == ProductCategory.isaMp)
                                Column(
                                  children: [
                                    const SizedBox(height: 8.0),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "기준년도",
                                        style: textTheme.bodyMedium!.copyWith(
                                          color: colorScheme.onTertiary,
                                        ),
                                      ),
                                    ),
                                    CustomYearPicker(
                                      selectedYear:
                                          int.tryParse(
                                            data["기준년도"]!.first.$1,
                                          ) ??
                                          DateTime.now().year,
                                      onYearChanged: (value) => ref
                                          .read(
                                            dialogFiltersViewModelProvider(
                                              category,
                                            ).notifier,
                                          )
                                          .selectBaseYear(value.toString()),
                                    ),
                                    const SizedBox(height: 8.0),
                                  ],
                                ),
                              ...data.entries.map((e) {
                                if (e.key == "기준년도") {
                                  return SizedBox(height: 8.0);
                                }
                                return ProductFilterCondition(
                                  category: category,
                                  filter: e.key,
                                  filterList: e.value,
                                );
                              }),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  error: (error, stack) => const Expanded(child: ShowingErrorWidget()),
                  loading: () =>
                      const Expanded(child: CustomProgressIndicator()),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          final notifier = ref.read(
                            dialogFiltersViewModelProvider(category).notifier,
                          );
                          await notifier.applyChanges("1");
                          if (context.mounted) Navigator.pop(ctx);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: colorScheme.tertiary,
                          side: BorderSide(
                            color: colorScheme.outline,
                            width: 1.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10.0),
                          ),
                        ),
                        child: Text(
                          "필터 적용",
                          style: textTheme.titleMedium!.copyWith(
                            color: colorScheme.onPrimary,
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
