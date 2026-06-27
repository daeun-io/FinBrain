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

class IsaBaseScreen extends ConsumerStatefulWidget {
  const IsaBaseScreen({super.key, required this.category});

  final FilterTextCategory category;

  @override
  ConsumerState<IsaBaseScreen> createState() => _IsaBaseScreenState();
}

class _IsaBaseScreenState extends ConsumerState<IsaBaseScreen> {
  final ScrollController _controller = ScrollController();
  final GlobalKey _centerKey = GlobalKey();
  bool _isLoading = false;
  int _cPage = 1;
  late int totalCount;
  
  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() async {
    if (_isLoading) return;
    final position = _controller.position;
    if (position.pixels >= position.maxScrollExtent - 100) {
      final data = ref.read(
        (widget.category == FilterTextCategory.isaJoin)
            ? isaJoinStatusViewModelProvider
            : isaManagementStatusViewModelProvider,
      );
      if (data.hasValue && data.value != null) {
        totalCount = data.value!.$1;
      }
      final maxPage = totalCount ~/ (100 * _cPage) + 1;
      if (_cPage < maxPage) {
        setState(() {
          _isLoading = true;
          _cPage++;
        });
        print("_cPage: $_cPage");
        await _fetchData();
        setState(() {
          _isLoading = false;
        });
      }
    }
    if (position.pixels <= position.minScrollExtent + 100) {
      print("_cPage: $_cPage");
      if (_cPage > 1) {
        setState(() {
          _isLoading = true;
          _cPage--;
        });
        await _fetchData();
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _fetchData() async {
    if (widget.category == FilterTextCategory.isaJoin) {
      ref
          .read(isaJoinStatusViewModelProvider.notifier)
          .fetchIsaJoinStatus(_cPage.toString());
    } else {
      ref
          .read(isaManagementStatusViewModelProvider.notifier)
          .fetchIsaManagementStatus(_cPage.toString());
    }
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(
      (widget.category == FilterTextCategory.isaJoin)
          ? isaJoinStatusViewModelProvider
          : isaManagementStatusViewModelProvider,
    );
    final filters = ref.watch(filtersViewmodelProvider(widget.category));
    final column = (widget.category == FilterTextCategory.isaJoin)
        ? ["ISA 종류", "회사 수", "가입자 수", "업권값"]
        : ["ISA 종류", "업권", "편입자산 구분", "구분값", "금액/비율"];

    // Move to center after fetching data
    ref.listen(
      (widget.category == FilterTextCategory.isaJoin
          ? isaJoinStatusViewModelProvider
          : isaManagementStatusViewModelProvider),
      (prev, next) {
        if (next.hasValue && prev?.value != next.value) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_controller.hasClients) {
              _controller.jumpTo(0);
            }
          });
        }
      },
    );

    return Column(
      children: [
        const SizedBox(height: 16.0),
        ProductFilter(
          productCategory: ProductCategory.isa,
          filterTextCategory: widget.category,
        ),
        const SizedBox(height: 24.0),
        SortOrFilterText(
          category: widget.category,
          onSortCriteriaChanged: (criteria) {
            (widget.category == FilterTextCategory.isaJoin)
                ? ref
                      .read(isaJoinStatusViewModelProvider.notifier)
                      .sortByCriteria(criteria, totalCount)
                : ref
                      .read(isaManagementStatusViewModelProvider.notifier)
                      .sortByCriteria(criteria, totalCount);
          },
        ),
        items.when(
          data: (data) {
            final (maxPage, items) = data;
            final index = items.length ~/ 2;
            final prevItems = items.sublist(0, index);
            final nextItems = items.sublist(index);

            return Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: primary300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // header
                          Container(
                            height: 40.0,
                            color: primary100,
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
                                      child: Text(
                                        label,
                                        style: const TextStyle(
                                          color: textPrimary,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
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
                              center: _centerKey,
                              physics: const BouncingScrollPhysics(),
                              slivers: [
                                SliverList(
                                  delegate: SliverChildBuilderDelegate((
                                    context,
                                    index,
                                  ) {
                                    final item =
                                        prevItems[prevItems.length - 1 - index];
                                    return _buildTableRow(item);
                                  }, childCount: prevItems.length),
                                ),
                                SliverPadding(
                                  key: _centerKey,
                                  padding: EdgeInsets.zero,
                                ),
                                SliverList(
                                  delegate: SliverChildBuilderDelegate((
                                    context,
                                    index,
                                  ) {
                                    final item = nextItems[index];
                                    return _buildTableRow(item);
                                  }, childCount: nextItems.length),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(right: 0, bottom: 0, child: AiButton()),
                ],
              ),
            );
          },
          error: (err, stack) => Expanded(
            child: Center(
              child: Text(
                "오류가 발생했습니다. 다시 시도해주세요",
                style: TextStyle(
                  color: black,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          loading: () =>
              Center(child: const CircularProgressIndicator(color: primary500)),
        ),
      ],
    );
  }

  Widget rowCell(String text, String type) {
    return Flexible(
      flex: (type == "incAstCtg" || type == "isaForm") ? 3 : 2,
      child: Center(
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

  Widget _buildTableRow(Object item) {
    return Container(
      height: 48.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          if (widget.category == FilterTextCategory.isaJoin) ...[
            rowCell((item as IsaJoinStatus).isaForm!, "isaForm"),
            rowCell(item.companyCount.toString(), "cmpyCnt"),
            rowCell(item.joinMemberCount.toString(), "jnMbCnt"),
            rowCell(item.category!, "category"),
          ] else ...[
            rowCell((item as IsaManagementStatus).isaForm!, "isaForm"),
            rowCell(item.businessDomain!, "bzds"),
            rowCell(item.includeAssetCtg!, "incAstCtg"),
            rowCell(item.category!, "category"),
            rowCell(item.amount.toString(), "amount"),
          ],
        ],
      ),
    );
  }
}
