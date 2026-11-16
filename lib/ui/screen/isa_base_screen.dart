import 'package:finbrain/data/model/entities/isa_join_status.dart';
import 'package:finbrain/data/model/entities/isa_management_status.dart';
import 'package:finbrain/themes/text_theme.dart';
import 'package:finbrain/ui/viewmodel/filters_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/sort_or_filter_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/text_theme_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/isa_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/no_data_found.dart';
import 'package:finbrain/ui/widget/showing_error_widget.dart';
import 'package:finbrain/ui/widget/sort_or_filter.dart';
import 'package:finbrain/ui/widget/product_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// ISA 가입 및 운용 현황 스크린
// ISA join and management status screen
class IsaBaseScreen extends ConsumerStatefulWidget {
  const IsaBaseScreen({super.key, required this.category});

  final ProductCategory category;

  @override
  ConsumerState<IsaBaseScreen> createState() => _IsaBaseScreenState();
}

class _IsaBaseScreenState extends ConsumerState<IsaBaseScreen> {
  final ScrollController _controller = ScrollController();
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    // 데이터와 헤더 칼럼(data and header column)
    final isaStatus = ref.watch(isaStatusViewmodelProvider(widget.category));
    final column = (widget.category == ProductCategory.isaJoin)
        ? ["기준일자", "ISA 종류", "회사 수", "가입자 수", "업권값"]
        : ["기준일자", "ISA 종류", "업권", "편입자산 구분", "구분값", "금액/비율"];

    // ISA 가입 및 운용 현황 필터 불러오기
    // Fetch current ISA filter of isa join/management filter
    final filters = ref.watch(filtersViewmodelProvider(widget.category));
    final baseYear =
        filters
            .whenData(
              (data) => data["기준년도"]!.firstWhere((e) => e.$2 == true).$1,
            )
            .value ??
        "";

    return Column(
      children: [
        const SizedBox(height: 24.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 필터 버튼(filter button)
            ProductFilter(category: widget.category),
            // 정렬 바텀시트(sorting bottom sheet)
            Expanded(
              child: SortOrFilterText(
                category: widget.category,
                baseYear: baseYear,
                onSortCriteriaChanged: (criteria) {
                  ref
                      .read(
                        sortOrFilterTextViewModelProvider(
                          widget.category,
                        ).notifier,
                      )
                      .changeCriteria(criteria);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 24.0),
        isaStatus.when(
          data: (data) {
            if (data.isEmpty) {
              return Expanded(
                child: NoDataFound(ctg: widget.category, isProduct: false),
              );
            }
            return Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: colorScheme.outline),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 헤더 칼럼(header column)
                      Header(
                        column,
                        colorScheme.secondary,
                        textTheme.titleMedium!.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                        textTheme,
                      ),
                      // 데이터 행(data row)
                      Expanded(
                        child: CustomScrollView(
                          controller: _controller,
                          center: _key,
                          physics: const BouncingScrollPhysics(),
                          slivers: [
                            const SliverPadding(
                              padding: EdgeInsets.only(top: 20.0),
                            ),
                            SliverPadding(key: _key, padding: EdgeInsets.zero),
                            SliverList(
                              delegate: SliverChildBuilderDelegate((
                                context,
                                index,
                              ) {
                                final item = data[index];
                                return IsaTableRow(
                                  item,
                                  colorScheme.surface,
                                  colorScheme.onSecondary,
                                  textTheme.bodyMedium!,
                                  textTheme,
                                );
                              }, childCount: data.length),
                            ),
                            const SliverPadding(
                              padding: EdgeInsets.only(bottom: 20.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          error: (err, stack) => const Expanded(child: ShowingErrorWidget()),
          loading: () => const Expanded(child: CustomProgressIndicator()),
        ),
      ],
    );
  }

  Widget Header(
    List<String> column,
    Color bgColor,
    TextStyle style,
    TextTheme currentTextTheme,
  ) {
    return Container(
      height: (currentTextTheme == bigTextTheme) ? 80.0 : 60.0,
      color: bgColor,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          for (final label in column)
            Flexible(
              flex: (label == "ISA 종류" || label == "편입자산 구분") ? 3 : 2,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(label, style: style),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget IsaTableRow(
    Object item,
    Color ctnColor,
    Color txtColor,
    TextStyle style,
    TextTheme currentTheme,
  ) {
    return Container(
      color: ctnColor,
      height: (currentTheme == bigTextTheme) ? 80.0 : 60.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          if (widget.category == ProductCategory.isaJoin &&
              (item as IsaJoinStatus).baseDate != null) ...[
            RowCell(
              (item.baseDate!.length == 8)
                  ? "${item.baseDate!.substring(4, 6)}/${item.baseDate!.substring(6)}"
                  : "${item.baseDate!.substring(4)}/${item.baseDate!.substring(5)}",
              "date",
              txtColor,
              style,
            ),
            RowCell(item.isaForm!, "isaForm", txtColor, style),
            RowCell(item.companyCount.toString(), "cmpyCnt", txtColor, style),
            RowCell(
              item.joinMemberCount.toString(),
              "jnMbCnt",
              txtColor,
              style,
            ),
            RowCell(item.category!, "category", txtColor, style),
          ] else if ((item as IsaManagementStatus).baseDate != null) ...[
            RowCell(
              (item.baseDate!.length == 8)
                  ? "${item.baseDate!.substring(4, 6)}/${item.baseDate!.substring(6)}"
                  : "${item.baseDate!.substring(4)}/${item.baseDate!.substring(5)}",
              "date",
              txtColor,
              style,
            ),
            RowCell(item.isaForm!, "isaForm", txtColor, style),
            RowCell(item.businessDomain!, "bzds", txtColor, style),
            RowCell(item.includeAssetCtg!, "incAstCtg", txtColor, style),
            RowCell(item.category!, "category", txtColor, style),
            RowCell(item.amount.toString(), "amount", txtColor, style),
          ],
        ],
      ),
    );
  }

  Widget RowCell(String text, String type, Color color, TextStyle style) {
    final formatter = NumberFormat("###,##0.##", "en_US");
    final number = double.tryParse(text);
    return Flexible(
      flex: (type == "incAstCtg" || type == "isaForm") ? 3 : 2,
      child: Center(
        child: Text(
          (number == null) ? text : formatter.format(number),
          style: style.copyWith(color: color),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
