import 'package:finbrain/data/model/entities/isa_join_status.dart';
import 'package:finbrain/data/model/entities/isa_management_status.dart';
import 'package:finbrain/themes/text_theme.dart';
import 'package:finbrain/ui/viewmodel/current_page_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/filters_viewmodel.dart';
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

class IsaBaseScreen extends ConsumerStatefulWidget {
  const IsaBaseScreen({super.key, required this.category});

  final ProductCategory category;

  @override
  ConsumerState<IsaBaseScreen> createState() => _IsaBaseScreenState();
}

class _IsaBaseScreenState extends ConsumerState<IsaBaseScreen> {
  final ScrollController _controller = ScrollController();
  final GlobalKey _key = GlobalKey();
  bool _isLoading = false;
  late int _cPage;
  int _totalCount = 0;
  int _maxPage = 0;

  @override
  void initState() {
    super.initState();
    _cPage = ref.read(currentPageViewmodelProvider(widget.category));
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() async {
    if (_isLoading) return;
    final cJoinPage = ref.read(
      currentPageViewmodelProvider(ProductCategory.isaJoin),
    );
    final cMngmPage = ref.read(currentPageViewmodelProvider(ProductCategory.isaManagement));
    final position = _controller.position;

    if (widget.category == ProductCategory.isaJoin) {
      if (position.pixels >= position.maxScrollExtent) {
        if (cJoinPage < _maxPage) {
          _isLoading = true;
          ref
              .read(
                currentPageViewmodelProvider(ProductCategory.isaJoin).notifier,
              )
              .setCurrentPage(cJoinPage + 1);
          _isLoading = false;
        } else {
          _isLoading = false;
        }
      } else if (position.pixels <= position.minScrollExtent) {
        if (cJoinPage > 1) {
          _isLoading = true;
          ref
              .read(
                currentPageViewmodelProvider(ProductCategory.isaJoin).notifier,
              )
              .setCurrentPage(cJoinPage - 1);
          _isLoading = false;
        } else {
          _isLoading = false;
        }
      }
    } else {
      if (position.pixels >= position.maxScrollExtent) {
        if (cMngmPage < _maxPage) {
          _isLoading = true;
          ref
              .read(
                currentPageViewmodelProvider(
                  ProductCategory.isaManagement,
                ).notifier,
              )
              .setCurrentPage(cMngmPage + 1);
          _isLoading = false;
        } else {
          _isLoading = false;
        }
      } else if (position.pixels <= position.minScrollExtent) {
        if (cMngmPage > 1) {
          _isLoading = true;
          ref
              .read(
                currentPageViewmodelProvider(
                  ProductCategory.isaManagement,
                ).notifier,
              )
              .setCurrentPage(cMngmPage - 1);
          _isLoading = false;
        } else {
          _isLoading = false;
        }
      }
    }
  }

  // Future<void> _fetchData() async {
  //   if (widget.category == ProductCategory.isaJoin) {
  //     final data = await ref.read(
  //       fetchIsaJoinStatusViewmodelProvider("$_cPage").future,
  //     );
  //     if (data.$1 == -1) {
  //       _cPage++;
  //       final pData = await ref.read(
  //         fetchIsaJoinStatusViewmodelProvider("$_cPage").future,
  //       );
  //       _totalCount = pData.$1;
  //     } else {
  //       _totalCount = data.$1;
  //     }
  //     _maxPage = (_totalCount == 0) ? 1 : (_totalCount - 1) ~/ 100 + 1;
  //     ref
  //         .read(currentPageViewmodelProvider(ProductCategory.isaJoin).notifier)
  //         .setCurrentPage(_cPage);
  //   } else {
  //     final data = await ref.read(
  //       fetchIsaMngmStatusViewmodelProvider("$_cPage").future,
  //     );
  //     if (data.$1 == -1) {
  //       _cPage++;
  //       final pData = await ref.read(
  //         fetchIsaMngmStatusViewmodelProvider("$_cPage").future,
  //       );
  //       _totalCount = pData.$1;
  //       _maxPage = (_totalCount == 0) ? 1 : (_totalCount - 1) ~/ 100 + 1;
  //     } else {
  //       _totalCount = data.$1;
  //       _maxPage = (_totalCount == 0) ? 1 : (_totalCount - 1) ~/ 100 + 1;
  //     }
  //     ref
  //         .read(
  //           currentPageViewmodelProvider(
  //             ProductCategory.isaManagement,
  //           ).notifier,
  //         )
  //         .setCurrentPage(_cPage);
  //   }

  //   await Future.delayed(const Duration(seconds: 1));
  // }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final currentTextTheme = ref.watch(textThemeViewmodelProvider);

    final joinItems = ref.watch(isaJoinStatusViewModelProvider);
    final joinColumn = ["ISA 종류", "회사 수", "가입자 수", "업권값"];
    final mngmItems = ref.watch(isaManagementStatusViewModelProvider);
    final mngmColumn = ["ISA 종류", "업권", "편입자산 구분", "구분값", "금액/비율"];

    final joinPage = ref.watch(
      currentPageViewmodelProvider(ProductCategory.isaJoin),
    );
    final mngmPage = ref.watch(
      currentPageViewmodelProvider(ProductCategory.isaManagement),
    );

    // ref.listen(filtersViewmodelProvider(widget.category), (prev, next) {
    //   if (prev != next) {
    //     _fetchData();
    //   }
    // });

    // Move to center after fetching data
    ref.listen(isaJoinStatusViewModelProvider, (prev, next) {
      if (next.hasValue && prev?.value != next.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_controller.hasClients) {
            _controller.jumpTo(0);
          }
        });
      }
    });
    ref.listen(isaManagementStatusViewModelProvider, (prev, next) {
      if (next.hasValue && prev?.value != next.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_controller.hasClients) {
            _controller.jumpTo(0);
          }
        });
      }
    });

    final filters = ref.watch(filtersViewmodelProvider(widget.category));
    final baseYear =
        filters
            .whenData(
              (data) => data["기준년도"]!.firstWhere((e) => e.$2 == true).$1,
            )
            .value ??
        "";

    final column = (widget.category == ProductCategory.isaJoin)
        ? joinColumn
        : mngmColumn;
    return Column(
      children: [
        const SizedBox(height: 24.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProductFilter(category: widget.category),
            Expanded(
              child: SortOrFilterText(
                category: widget.category,
                baseYear: baseYear,
                onSortCriteriaChanged: (criteria) {
                  (widget.category == ProductCategory.isaJoin)
                      ? ref
                            .read(isaJoinStatusViewModelProvider.notifier)
                            .sortByCriteria(criteria, _totalCount)
                      : ref
                            .read(isaManagementStatusViewModelProvider.notifier)
                            .sortByCriteria(criteria, _totalCount);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 24.0),
        ((widget.category == ProductCategory.isaJoin) ? joinItems : mngmItems)
            .when(
              data: (data) {
                final (totalCount, items) = data;
                _totalCount = totalCount;
                _maxPage = (totalCount == 0)
                    ? 1
                    : (totalCount - 1) ~/ 200 + 1;
                print("max page in isa base, $_maxPage");
                print("current page in isa base, ${(widget.category == ProductCategory.isaJoin) ? joinPage : mngmPage}");
                print("total count in isa base, $_totalCount");
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
                          // header
                          Container(
                            height: (currentTextTheme == bigTextTheme)
                                ? 80.0
                                : 60.0,
                            color: colorScheme.secondary,
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                for (final label in column)
                                  Flexible(
                                    flex:
                                        (label == "ISA 종류" ||
                                            label == "편입자산 구분")
                                        ? 3
                                        : 2,
                                    child: Center(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          label,
                                          style: textTheme.titleMedium!
                                              .copyWith(
                                                color: colorScheme.onPrimary,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          // rows
                          Expanded(
                            child: CustomScrollView(
                              controller: _controller,
                              center: _key,
                              physics: const BouncingScrollPhysics(),
                              slivers: [
                                const SliverPadding(
                                  padding: EdgeInsets.only(top: 40.0),
                                ),
                                SliverPadding(
                                  key: _key,
                                  padding: EdgeInsets.zero,
                                ),
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
                                      currentTextTheme,
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
              error: (err, stack) =>
                  const Expanded(child: ShowingErrorWidget()),
              loading: () => const Expanded(child: CustomProgressIndicator()),
            ),
      ],
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
