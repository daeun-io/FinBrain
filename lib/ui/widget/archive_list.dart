import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewmodel/archive_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArchiveList extends ConsumerWidget {
  const ArchiveList({super.key, required this.ctg, required this.records});

  final ArchiveCategory ctg;
  final List<AiRecord> records;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return 
    SingleChildScrollView(
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
                      if (ctg == ArchiveCategory.comparison) {
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
                    if (ctg == ArchiveCategory.comparison) {
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
                    (ctg == ArchiveCategory.summary)
                        ? item.key
                        : item.key.substring(8).replaceAll("-", " vs "),
                    style: TextStyle(
                      fontSize: 14.0,
                      color: colorScheme.onSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  children: item.value.map((chat) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              chat.createdAt.toIso8601String().split("T").first,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                                color: colorScheme.onTertiary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              chat.text,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                                color: colorScheme.onSecondary,
                              ),
                            ),
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
