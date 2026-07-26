import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/themes/text_style.dart';
import 'package:finbrain/ui/viewmodel/archive_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/markdown_text_render.dart';
import 'package:finbrain/ui/widget/showing_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArchiveTabViewScreen extends ConsumerWidget {
  const ArchiveTabViewScreen({super.key, required this.category});
  final ArchiveCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // AI 응답 필터
    // AI response filter
    final filterCtg = [
      ProductCategory.deposit,
      ProductCategory.installment,
      ProductCategory.isaMp,
      ProductCategory.mortgage,
      ProductCategory.rent,
      ProductCategory.credit,
    ];
    final compTextfilters = ref.watch(selectedCtgForCompTextViewmodelProvider);
    final summariesFilters = ref.watch(
      selectedCtgForSummariesViewmodelProvider,
    );
    // AI 요약 및 비교
    // AI summaries and comparison texts
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
                // 필터 칩(filter chip)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 8.0,
                    children: filterCtg.map((e) {
                      return categoryFilterChip(
                        ref,
                        e,
                        (category == ArchiveCategory.comparison)
                            ? compTextfilters
                            : summariesFilters,
                        colorScheme,
                        textTheme,
                      );
                    }).toList(),
                  ),
                ),
                // 응답 리스트(response list)
                Expanded(
                  child: (category == ArchiveCategory.comparison)
                      ? archiveList(data, colorScheme, ref)
                      : archiveList(data, colorScheme, ref),
                ),
              ],
            ),
          ),
          error: (error, stackTrace) {
            return const ShowingErrorWidget();
          },
          loading: () => const CustomProgressIndicator(),
        );
  }
  
  FilterChip categoryFilterChip(
    WidgetRef ref,
    ProductCategory ctg,
    List<ProductCategory> filters,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return FilterChip(
      // 필터 선택 및 제거
      // select and delete filter 
      onSelected: (selected) {
        if (selected) {
          if (category == ArchiveCategory.comparison) {
            ref
                .read(selectedCtgForCompTextViewmodelProvider.notifier)
                .addCtg(ctg);
          } else {
            ref
                .read(selectedCtgForSummariesViewmodelProvider.notifier)
                .addCtg(ctg);
          }
        } else {
          if (category == ArchiveCategory.comparison) {
            ref
                .read(selectedCtgForCompTextViewmodelProvider.notifier)
                .deleteCtg(ctg);
          } else {
            ref
                .read(selectedCtgForSummariesViewmodelProvider.notifier)
                .deleteCtg(ctg);
          }
        }
      },
      selected: filters.contains(ctg),
      selectedColor: colorScheme.surfaceContainerHigh,
      backgroundColor: colorScheme.secondary,
      checkmarkColor: colorScheme.onSurface,
      label: Text(
        switch (ctg) {
          ProductCategory.deposit => "정기예금",
          ProductCategory.installment => "적금",
          ProductCategory.mortgage => "주택담보대출",
          ProductCategory.rent => "전세자금대출",
          ProductCategory.credit => "개인신용대출",
          ProductCategory.isaMp => "ISA",
          _ => "",
        },
        style: (filters.contains(ctg))
            ? textTheme.bodyMedium!.copyWith(color: colorScheme.onSurface)
            : textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary),
      ),
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
                      // 응답 고정 등록/해제
                      // pin/unpin response
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
                  // 타일 펼치고 닫기
                  // expand/collpase tile
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
                        ? item.name.replaceAll(r'\\n', "")
                        : item.name
                              .replaceAll("`", " vs ")
                              .replaceAll(r'\\n', ""),
                    style: bodyRgMd.copyWith(color: colorScheme.onSecondary),
                  ),
                  children: item.value.map((chat) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              chat.createdAt.toIso8601String().split("T").first,
                              style: bodyRgSm.copyWith(
                                color: colorScheme.onTertiary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: MarkdownTextRenderer(str: chat.text),
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
