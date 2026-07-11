import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/themes/text_style.dart';
import 'package:finbrain/ui/viewModel/archive_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/markdown_text_render.dart';
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
                              ? bodyRgMd.copyWith(color: colorScheme.onSurface)
                              : bodyRgMd.copyWith(color: colorScheme.onSecondary)
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: (category == ArchiveCategory.comparison)
                      ? archiveList(data, colorScheme, ref)
                      : archiveList(data, colorScheme, ref),
                ),
              ],
            ),
          ),
          error: (error, stackTrace) {
            print("Error occured in archive screen, $error");
            print("stack trace: $stackTrace");
            return Center(child: Text("오류가 발생했습니다!\n다시 시도해주세요"));
          },
          loading: () => const CustomProgressIndicator(),
        );
  }

  Widget archiveList(
    List<AiRecord> records,
    ColorScheme colorScheme,
    WidgetRef ref,
  ) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 24.0),
          ...records.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: ExpansionTile(
                  leading: IconButton(
                    onPressed: () {
                      if (category == ArchiveCategory.comparison) {
                        ref
                            .read(archiveComparisonViewmodelProvider.notifier)
                            .pinRecord(item);
                      } else {
                        ref
                            .read(archiveSummaryViewmodelProvider.notifier)
                            .pinRecord(item);
                      }
                    },
                    icon: item.isPinned
                        ? Icon(
                            Icons.star,
                            color: colorScheme.onSecondaryFixed,
                            size: 24,
                          )
                        : Icon(
                            Icons.star_border,
                            color: colorScheme.onSecondaryFixedVariant,
                            size: 24,
                          ),
                  ),
                  onExpansionChanged: (expanded) {
                    if (category == ArchiveCategory.comparison) {
                      ref
                          .read(archiveComparisonViewmodelProvider.notifier)
                          .expandRecord(item);
                    } else {
                      ref
                          .read(archiveSummaryViewmodelProvider.notifier)
                          .expandRecord(item);
                    }
                  },
                  initiallyExpanded: item.isExpanded,
                  backgroundColor: colorScheme.secondary,
                  collapsedBackgroundColor: colorScheme.secondary,
                  iconColor: colorScheme.onPrimary,
                  collapsedIconColor: colorScheme.onPrimary,
                  shape: const Border(),
                  title: Text(
                    (category == ArchiveCategory.summary)
                        ? item.key
                        : item.key.substring(8).replaceAll("-", " vs "),
                    style: bodyRgMd.copyWith(color: colorScheme.onSecondary),
                  ),
                  children: item.value.map((chat) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              chat.createdAt.toIso8601String().split("T").first,
                              style: bodyRgSm.copyWith(color: colorScheme.onTertiary)
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: MarkdownTextRenderer(str: chat.text)
                          ),
                          const SizedBox(height: 12.0),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
