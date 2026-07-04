import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/viewmodel/archive_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArchiveList extends ConsumerWidget {
  const ArchiveList({super.key, required this.ctg, required this.records});

  final ArchiveCategory ctg;
  final List<AiRecord> records;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 24.0),
          ...records.map((item) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: ExpansionTile(
                leading: IconButton(
                  onPressed: () {
                    ref.watch(archiveSummaryViewmodelProvider.notifier).pinRecord(item);
                    // setState(() {
                      // widget.records.remove(item);
                      // widget.records.insert(0, item);
                      // item.isPinned = !item.isPinned;
                    // });
                  },
                  icon: item.isPinned
                      ? Icon(Icons.star, color: robotBulb, size: 24)
                      : Icon(Icons.star_border, color: textSecondary, size: 24),
                ),
                onExpansionChanged: (expanded) {
                  // item.isExpanded = expanded;
                  ref.watch(archiveSummaryViewmodelProvider.notifier).expandRecord(item);
                },
                initiallyExpanded: item.isExpanded,
                backgroundColor: white,
                collapsedBackgroundColor: white,
                iconColor: textPrimary,
                collapsedIconColor: textPrimary,
                shape: const Border(),
                title: Text(
                  item.key,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: black,
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
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              color: textSecondary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            chat.text,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                              color: black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12.0),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          }),
        ],
      ),
    );
  }
}
