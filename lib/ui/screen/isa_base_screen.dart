import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/product_category.dart';
import 'package:finbrain/ui/widget/ai_button.dart';
import 'package:finbrain/ui/widget/filter_text.dart';
import 'package:finbrain/ui/widget/product_filter.dart';
import 'package:flutter/material.dart';

class IsaBaseScreen extends StatelessWidget{
  const IsaBaseScreen({
    super.key,
    required this.category
  });
  
  final IsaCategory category; 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16.0,),
        const ProductFilter(),
        const SizedBox(height: 24.0,),
        const FilterText(),
        Expanded(
          child: Stack(children: [
            SingleChildScrollView(
              child: DataTable(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primary300
                  )
                ),
                headingRowColor: const WidgetStatePropertyAll(primary100),
                headingRowHeight: 40.0,
                columnSpacing: 36,
                dividerThickness: 0.0,
                columns: const [
                  DataColumn(label: Text(
                    "ISA 종류",
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600
                    ),
                  )),
                  DataColumn(label: Text(
                    "회사 수",
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600
                    ),
                  )),
                  DataColumn(label: Text(
                    "가입자 수",
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600
                    ),
                  )),
                  DataColumn(label: Text(
                    "업권값",
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600
                    ),
                  ))
                ], 
                rows: const [
                  DataRow(cells:[
                    DataCell(Text(
                      "투자중개형 ISA",
                      style: TextStyle(
                        color: textPrimary,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400
                      ),
                    )),
                    DataCell(Text(
                      "25",
                      style: TextStyle(
                        color: textPrimary,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400
                      ),
                    )),
                    DataCell(Text(
                      "7,419,913",
                      style: TextStyle(
                        color: textPrimary,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400
                      ),
                    )),
                    DataCell(Text(
                      "총합",
                      style: TextStyle(
                        color: textPrimary,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400
                      ),
                    )),
                  ])
                ]
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: AiButton()
            ),
          ],),
        )
      ],
    );
  }
}