import 'package:finbrain/data/models/entities/isa_join_status.dart';
import 'package:finbrain/data/models/entities/isa_management_status.dart';
import 'package:finbrain/data/viewModel/filters_viewmodel.dart';
import 'package:finbrain/data/viewModel/isa_viewmodel.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/widget/ai_button.dart';
import 'package:finbrain/ui/widget/sort_or_filter.dart';
import 'package:finbrain/ui/widget/product_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IsaBaseScreen extends ConsumerWidget {
  const IsaBaseScreen({super.key, required this.category});

  final FilterTextCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final joinProvider = isaJoinStatusViewModelProvider(
      "1",
      "100",
      "2026",
      "",
      "",
    );
    final mngmProvider = isaManagementStatusViewModelProvider(
      "1",
      "100",
      "2026",
      "비중",
      "",
      "",
    );
    final items = (category == FilterTextCategory.isaJoin)
        ? ref.watch(joinProvider)
        : ref.watch(mngmProvider);

    final filters = ref.watch(
      filtersViewmodelProvider(category),
    );

    final column = (category == FilterTextCategory.isaJoin)
        ? ["ISA 종류", "회사 수", "가입자 수", "업권값"]
        : ["ISA 종류", "업권", "편입자산 구분", "구분값", "금액/비율"];

    return Column(
      children: [
        const SizedBox(height: 16.0),
        ProductFilter(filterTextCategory: category),
        const SizedBox(height: 24.0),
        SortOrFilterText(
          category: category,
          onSortCriteriaChanged: (criteria) {
            (category == FilterTextCategory.isaJoin)
                ? ref.read(joinProvider.notifier).sortByCriteria(criteria)
                : ref.read(mngmProvider.notifier).sortByCriteria(criteria);
          },
        ),
        Expanded(
          child: Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    decoration: BoxDecoration(
                      border: Border.all(color: primary300),
                    ),
                    headingRowColor: const WidgetStatePropertyAll(primary100),
                    headingRowHeight: 40.0,
                    columnSpacing: 36,
                    dividerThickness: 0.0,
                    columns: [for (final label in column) columnText(label)],
                    rows: [
                      if (items.valueOrNull != null)
                        for (final item in items.value!)
                          DataRow(
                            cells: [
                              if (category == FilterTextCategory.isaJoin) ...[
                                dataCell((item as IsaJoinStatus).isaForm!),
                                dataCell(item.companyCount.toString()),
                                dataCell(item.joinMemberCount.toString()),
                                dataCell(item.category!),
                              ] else ...[
                                dataCell(
                                  (item as IsaManagementStatus).isaForm!,
                                ),
                                dataCell(item.businessDomain!),
                                dataCell(item.includeAssetCtg!),
                                dataCell(item.category!),
                                dataCell(item.amount.toString()),
                              ],
                            ],
                          ),
                    ],
                  ),
                ),
              ),
              Positioned(right: 0, bottom: 0, child: AiButton()),
            ],
          ),
        ),
      ],
    );
  }

  DataColumn columnText(String text) {
    return DataColumn(
      label: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: textPrimary,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataCell dataCell(String text) {
    return DataCell(
      Center(
        child: Text(
          text,
          style: TextStyle(
            color: textPrimary,
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
