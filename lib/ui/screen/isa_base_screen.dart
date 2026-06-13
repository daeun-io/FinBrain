import 'package:finbrain/data/model/entities/isa_join_status.dart';
import 'package:finbrain/data/model/entities/isa_management_status.dart';
import 'package:finbrain/provider/filters_provider.dart';
import 'package:finbrain/provider/isa_provider.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/product_categories.dart';
import 'package:finbrain/ui/widget/ai_button.dart';
import 'package:finbrain/ui/widget/sort_or_filter.dart';
import 'package:finbrain/ui/widget/product_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IsaBaseScreen extends ConsumerWidget {
  const IsaBaseScreen({super.key, required this.category});

  final IsaScreenCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dummyData = ref.watch(
      (category == IsaScreenCategory.join)
          ? isaJoinProvider
          : isaManagementProvider,
    );

    final filters = ref.watch(filtersNotifierProvider);

    final column = (category == IsaScreenCategory.join)
        ? ["ISA 종류", "회사 수", "가입자 수", "업권값"]
        : ["ISA 종류", "업권", "편입자산 구분", "구분값", "금액/비율"];

    return Column(
      children: [
        const SizedBox(height: 16.0),
        ProductFilter(category: ProductCategory.isa),
        const SizedBox(height: 24.0),
        SortOrFilterText(category: FilterTextCategory.isa, onSortCriteriaChanged: (criteria){},),
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
                      for (final data in dummyData)
                        DataRow(
                          cells: [
                            if (category == IsaScreenCategory.join) ...[
                              dataCell((data as IsaJoinStatus).isaForm!),
                              dataCell(data.companyCount.toString()),
                              dataCell(data.joinMemberCount.toString()),
                              dataCell(data.category!),
                            ] else ...[
                              dataCell((data as IsaManagementStatus).isaForm!),
                              dataCell(data.businessDomain!),
                              dataCell(data.includeAssetCtg!),
                              dataCell(data.category!),
                              dataCell(data.amount.toString())
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
