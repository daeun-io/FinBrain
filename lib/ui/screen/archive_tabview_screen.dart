import 'package:finbrain/product_categories.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/viewModel/archive_viewmodel.dart';
import 'package:finbrain/ui/widget/archive_list.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArchiveTabViewScreen extends ConsumerWidget {
  const ArchiveTabViewScreen({super.key, required this.category});
  final ArchiveCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final filterCtg = [
      ProductCategory.deposit,
      ProductCategory.installment,
      ProductCategory.isaMp,
      ProductCategory.mortgage,
      ProductCategory.rent,
      ProductCategory.credit,
      ProductCategory.annuity,
    ];
    final compTextfilters = ref.watch(selectedCtgForCompTextViewmodelProvider);
    final summariesFilters = ref.watch(
      selectedCtgForSummariesViewmodelProvider,
    );
    final compTexts = ref.watch(archiveComparisonViewmodelProvider);
    final summaries = ref.watch(archiveSummaryViewmodelProvider);

    return ((category == ArchiveCategory.comparison) ? compTexts : summaries)
        .when(
          data: (data) => Container(
            color: colorScheme.primary,
            padding: EdgeInsets.only(
              top: 24.0,
              left: 20.0,
              right: 20.0,
              bottom: 20.0,
            ),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 8.0,
                    children: filterCtg.map((e) {
                      return FilterChip(
                        onSelected: (selected) {
                          if (selected) {
                            if (category == ArchiveCategory.comparison) {
                              ref
                                  .read(
                                    selectedCtgForCompTextViewmodelProvider
                                        .notifier,
                                  )
                                  .addCtg(e);
                            } else {
                              ref
                                  .read(
                                    selectedCtgForSummariesViewmodelProvider
                                        .notifier,
                                  )
                                  .addCtg(e);
                            }
                          } else {
                            if (category == ArchiveCategory.comparison) {
                              ref
                                  .read(
                                    selectedCtgForCompTextViewmodelProvider
                                        .notifier,
                                  )
                                  .deleteCtg(e);
                            } else {
                              ref
                                  .read(
                                    selectedCtgForSummariesViewmodelProvider
                                        .notifier,
                                  )
                                  .deleteCtg(e);
                            }
                          }
                        },
                        selected:
                            ((category == ArchiveCategory.comparison)
                                    ? compTextfilters
                                    : summariesFilters)
                                .contains(e),
                        selectedColor: colorScheme.surfaceContainerHigh,
                        backgroundColor: colorScheme.secondary,
                        checkmarkColor: colorScheme.onSurface,
                        label: Text(
                          switch (e) {
                            ProductCategory.deposit => "정기예금",
                            ProductCategory.installment => "적금",
                            ProductCategory.mortgage => "주택담보대출",
                            ProductCategory.rent => "전세자금대출",
                            ProductCategory.credit => "개인신용대출",
                            ProductCategory.annuity => "연금저축",
                            ProductCategory.isaMp => "ISA",
                            _ => "",
                          },
                          style:
                              (((category == ArchiveCategory.comparison)
                                      ? compTextfilters
                                      : summariesFilters)
                                  .contains(e))
                              ? const TextStyle(
                                  color: white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                )
                              : const TextStyle(
                                  color: black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: (category == ArchiveCategory.comparison)
                      ? ArchiveList(
                          ctg: ArchiveCategory.comparison,
                          records: data,
                        )
                      : ArchiveList(
                          ctg: ArchiveCategory.summary,
                          records: data,
                        ),
                ),
              ],
            ),
          ),
          error: (error, stackTrace) {
            print("Error occured in archive screen, $error");
            print("stack trace: $stackTrace");
            return Center(child: Text("오류가 발생했습니다!\n다시 시도해주세요"));
          },
          loading: () => const CustomProgressIndicator()
        );
  }
}
