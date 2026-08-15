import 'package:finbrain/data/model/entities/isa_join_status.dart';
import 'package:finbrain/data/model/entities/isa_management_status.dart';
import 'package:finbrain/themes/text_theme.dart';
import 'package:finbrain/ui/viewmodel/current_page_viewmodel.dart';
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
  bool _isLoading = false; // 데이터 로딩 여부(loading data state)
  late int _cPage; // 현재 페이지(current page)
  int _maxPage = 0; // API 데이터 최대 페이지(api data max page)

  @override
  void initState() {
    super.initState();
    // 현재 페이지 불러오기
    // Fetch current page
    _cPage = ref.read(currentPageViewmodelProvider(widget.category));
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() async {
    // 데이터 로딩 중이면 함수 중단
    // Stop calling function when data is loading
    if (_isLoading) return;
    // 현재 페이지 불러오기
    // Fetch current page
    final _cPage = ref.read(currentPageViewmodelProvider(widget.category));
    // 현재 스크롤 위치(current scroll position)
    final position = _controller.position;

    if (position.maxScrollExtent <= 0) return;
    final statusAsync = ref.read(isaStatusViewmodelProvider(widget.category));
    if (statusAsync.isLoading) return;

    // 최하단 스크롤 위치에 도달하면 다음 페이지 불러오기(가입 현황)
    // Fetch next page when reached bottom of the list(join status)
    if (position.pixels >= position.maxScrollExtent) {
      if (_cPage < _maxPage) {
        _isLoading = true;
        ref
            .read(currentPageViewmodelProvider(widget.category).notifier)
            .setCurrentPage(_cPage + 1);
        _isLoading = false;
      } else {
        _isLoading = false;
      }
      // 최상단 위치에 도달하면 다음 페이지 불러오기(가입 현황)
      // Fetch previous page when reached top of the list(join status)
    } else if (position.pixels <= position.minScrollExtent) {
      if (_cPage > 1) {
        _isLoading = true;
        ref
            .read(currentPageViewmodelProvider(widget.category).notifier)
            .setCurrentPage(_cPage - 1);
        _isLoading = false;
      } else {
        _isLoading = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    // 데이터와 헤더 칼럼(data and header column)
    final isaStatus = ref.watch(isaStatusViewmodelProvider(widget.category));
    final column = (widget.category == ProductCategory.isaJoin)
        ? ["ISA 종류", "회사 수", "가입자 수", "업권값"]
        : ["ISA 종류", "업권", "편입자산 구분", "구분값", "금액/비율"];

    // 데이터 불러오면 상단으로 이동
    // Move to top after fetching data
    ref.listen(isaStatusViewmodelProvider(widget.category), (prev, next) {
      if (next.hasValue && prev?.value != next.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // 최대 개수 불러와 최대 페이지 계산
          // Fetch total count and calculate maximum page
          final (totalCount, _) = next.value!;
          _maxPage = (totalCount == 0) ? 1 : (totalCount - 1) ~/ 200 + 1;

          if (_controller.hasClients) {
            _controller.jumpTo(0);
          }
        });
      }
    });

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
            final (totalCount, items) = data;
            if (items.isEmpty) {
              return Expanded(
                child: NoDataFound(
                  ctg: widget.category,
                  isProduct: false,
                  isLastPage: (_cPage == _maxPage),
                ),
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
                      header(
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
                              padding: EdgeInsets.only(top: 40.0),
                            ),
                            SliverPadding(key: _key, padding: EdgeInsets.zero),
                            SliverList(
                              delegate: SliverChildBuilderDelegate((
                                context,
                                index,
                              ) {
                                final item = items[index];
                                return _buildTableRow(
                                  item,
                                  colorScheme.surface,
                                  colorScheme.onSecondary,
                                  textTheme.bodyMedium!,
                                  textTheme,
                                );
                              }, childCount: items.length),
                            ),
                            const SliverPadding(
                              padding: EdgeInsets.only(bottom: 40.0),
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

  Widget header(
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

  Widget rowCell(String text, String type, Color color, TextStyle style) {
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

  Widget _buildTableRow(
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
          if (widget.category == ProductCategory.isaJoin) ...[
            rowCell(
              (item as IsaJoinStatus).isaForm!,
              "isaForm",
              txtColor,
              style,
            ),
            rowCell(item.companyCount.toString(), "cmpyCnt", txtColor, style),
            rowCell(
              item.joinMemberCount.toString(),
              "jnMbCnt",
              txtColor,
              style,
            ),
            rowCell(item.category!, "category", txtColor, style),
          ] else ...[
            rowCell(
              (item as IsaManagementStatus).isaForm!,
              "isaForm",
              txtColor,
              style,
            ),
            rowCell(item.businessDomain!, "bzds", txtColor, style),
            rowCell(item.includeAssetCtg!, "incAstCtg", txtColor, style),
            rowCell(item.category!, "category", txtColor, style),
            rowCell(item.amount.toString(), "amount", txtColor, style),
          ],
        ],
      ),
    );
  }
}
