import 'package:finbrain/product_categories.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/viewmodel/archive_viewmodel.dart';
import 'package:finbrain/ui/widget/archive_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComparisonArchiveScreen extends ConsumerWidget {
  const ComparisonArchiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(selectedCtgForArchiveViewmodelProvider);
    final compTexts = ref.watch(archiveComparisonViewmodelProvider);

    return compTexts.when(
      data: (data) => Container(
        color: Color(0xFFF4F4F4),
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
                children: ProductCategory.values.map((e) {
                  return FilterChip(
                    onSelected: (selected) {
                      if (selected) {
                        ref.read(selectedCtgForArchiveViewmodelProvider.notifier).addCtg(e);
                      } else {
                        ref.read(selectedCtgForArchiveViewmodelProvider.notifier).deleteCtg(e);
                      }
                    },
                    selected: filters.contains(e),
                    selectedColor: primary700,
                    backgroundColor: white,
                    checkmarkColor: white,
                    label: Text(
                      switch (e) {
                        ProductCategory.deposit => "정기예금",
                        ProductCategory.installment => "적금",
                        ProductCategory.mortgage => "주택담보대출",
                        ProductCategory.rent => "전세자금대출",
                        ProductCategory.credit => "개인신용대출",
                        ProductCategory.annuity => "연금저축",
                        _ => "ISA",
                      },
                      style: (filters.contains(e))
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
              child: ArchiveList(
                ctg: ArchiveCategory.comparison,
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
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: primary400,
          backgroundColor: Color(0xFFF4F4F4),
        ),
      ),
    );
  }
}
