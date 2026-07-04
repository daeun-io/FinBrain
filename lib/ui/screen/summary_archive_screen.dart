import 'package:finbrain/product_categories.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/viewmodel/archive_viewmodel.dart';
import 'package:finbrain/ui/widget/archive_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SummaryArchiveScreen extends ConsumerWidget {
  const SummaryArchiveScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaries = ref.watch(archiveSummaryViewmodelProvider);
    return summaries.when(
      data: (data) => Container(
        color: Color(0xFFF4F4F4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ArchiveList(ctg: ArchiveCategory.summary, records: data),
        ),
      ),
      error: (error, stackTrace) {
        print("Error occured in archive screen, $error");
        print("stack trace: $stackTrace");
        return Center(child: Text("오류가 발생했습니다!\n다시 시도해주세요"));
      },
      loading: () => const Center(child: CircularProgressIndicator(color: primary400, backgroundColor: Color(0xFFF4F4F4),)),
    );
  }
}
