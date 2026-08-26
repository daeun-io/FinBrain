import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/ai_comparison_screen.dart';
import 'package:finbrain/ui/tutorial_helper.dart';
import 'package:finbrain/ui/viewModel/text_theme_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/liked_product_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/selected_prdt_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/ai_comp_tutorial_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_appbar.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/custom_snack_bar.dart';
import 'package:finbrain/ui/widget/product_item.dart';
import 'package:finbrain/ui/widget/search_box.dart';
import 'package:finbrain/ui/widget/showing_error_widget.dart';
import 'package:finbrain/ui/widget/sort_or_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class ProductSelectionScreen extends ConsumerStatefulWidget {
  const ProductSelectionScreen({super.key, this.isAiCompTutorial});
  
  final bool? isAiCompTutorial;
  @override
  ConsumerState<ProductSelectionScreen> createState() => _ProductScelectionScreenState();
}

class _ProductScelectionScreenState extends ConsumerState<ProductSelectionScreen> {
  // 튜토리얼을 위한 변수
  // Variables for tutorial
  final List<TargetFocus> targets = [];
  GlobalKey aiCompkey3 = GlobalKey();
  GlobalKey aiCompkey4 = GlobalKey();

  @override
  void initState() {
    super.initState();
    ref.read(aiCompTutorialViewmodelProvider.future).then((value) {
      if (value == false) {
        _showAiCompTutorial();
      }
    });
  }

  void _showAiCompTutorial() {
    initTarget(
      context,
      targets,
      aiCompkey3,
      ContentAlign.bottom,
      ShapeLightFocus.Circle,
      "체크박스를 통해 원하는 상품을 선택하세요\n선택한 상품의 카테고리는 반드시 동일해야 합니다",
    );
    initTarget(
      context,
      targets,
      aiCompkey4,
      ContentAlign.top,
      ShapeLightFocus.RRect,
      "상품 선택 이후 하단의 비교 분석 버튼을 클릭하면 AI가 상품을 비교 분석합니다",
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        Duration(milliseconds: 300),
        () => showTutorial(context, targets),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final liked = ref.watch(likedProductViewmodelProvider);
    final selectedProducts = ref.watch(selectedProductsViewmodelProvider);
    // 비교 분석 tag
    // AI Comparison response tag
    final prdtCodes = selectedProducts
        .map(
          (e) => (e.commonInfo.category == ProductCategory.isaMp)
              ? e.commonInfo.productName
              : e.commonInfo.productCode,
        )
        .whereType<String>()
        .join('`');
    // 비교 분석 name
    // AI Comparison response name
    final prdtNames = selectedProducts
        .map((e) => e.commonInfo.productName)
        .whereType<String>()
        .join('`');

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(screen: "product_selection", title: "상품 선택"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24.0, left: 20.0, right: 20.0),
              child: Column(
                children: [
                  // 검색창(search bar)
                  SearchBox(
                    searchItem: (value) {
                      ref
                          .read(likedProductViewmodelProvider.notifier)
                          .filterByKeyword(value);
                    },
                    fromLikedScreen: true,
                  ),
                  const SizedBox(height: 32.0),
                  // 필터링 바텀시트(filter bottom sheet)
                  SortOrFilterText(
                    category: ProductCategory.liked,
                    baseYear: "",
                    onSortCriteriaChanged: (criteria) {
                      ref
                          .read(likedProductViewmodelProvider.notifier)
                          .filterByCategory(criteria);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  liked.when(
                    data: (data) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: liked.value!.length,
                          itemBuilder: (context, index) {
                            final isSelected = selectedProducts.contains(
                              data[index],
                            );
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Row(
                                children: [
                                  IconButton(
                                    key: (index == 0) ? aiCompkey3 : null,
                                    icon: (isSelected)
                                        ? Icon(
                                            Icons.check_circle,
                                            color:
                                                colorScheme.surfaceContainerHigh,
                                            size: 36.0,
                                          )
                                        : Icon(
                                            Icons.circle_outlined,
                                            color: colorScheme.outline,
                                            size: 36.0,
                                          ),
                                    onPressed: () {
                                      if (isSelected) {
                                        ref
                                            .read(
                                              selectedProductsViewmodelProvider
                                                  .notifier,
                                            )
                                            .subtractProduct(data[index]);
                                      } else {
                                        ref
                                            .read(
                                              selectedProductsViewmodelProvider
                                                  .notifier,
                                            )
                                            .addProduct(data[index]);
                                      }
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: ProductItem(
                                      productCode:
                                          data[index].commonInfo.productCode ??
                                          "isaMp",
                                      productName:
                                          data[index].commonInfo.productName!,
                                      category: data[index].commonInfo.category,
                                      fromLikedScreen: true,
                                      isSelecting: true,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                    loading: () =>
                        const Expanded(child: CustomProgressIndicator()),
                    error: (error, stackTrace) =>
                        const Expanded(child: ShowingErrorWidget()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavToAiComparisonScreenBtn(
        context,
        ref,
        prdtCodes,
        prdtNames,
      ),
    );
  }

  // 선택된 상품을 갖고 비교 분석 화면으로 이동
  // Navigate to AI comparison screen with selected products
  Widget NavToAiComparisonScreenBtn(
    BuildContext context,
    WidgetRef ref,
    String prdtCodes,
    String prdtNames,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return GestureDetector(
      key: aiCompkey4,
      onTap: () {
        final num = ref
            .read(selectedProductsViewmodelProvider.notifier)
            .getNumOfProducts();
        if (num < 2) {
          CustomSnackBar.show(context, ref, text: "최소 2개 이상의 상품을 선택해주세요!");
        } else if (!ref
            .read(selectedProductsViewmodelProvider.notifier)
            .allCategoriesSame()) {
          CustomSnackBar.show(context, ref, text: "선택하신 상품들의 카테고리가 다릅니다!\n동일 카테고리의 상품을 비교해주세요");
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) {
                final ctg = ref
                    .read(selectedProductsViewmodelProvider.notifier)
                    .getCategory();
                if (ctg == null) {
                  CustomSnackBar.show(context, ref, text: "선택하신 상품의 카테고리가 존재하지 않습니다.\n다시 시도해주세요");
                  return const SizedBox.shrink();
                }
                return AiComparisonScreen(
                  tag: prdtCodes,
                  name: prdtNames,
                  ctg: ctg,
                  isAiCompTutorial: widget.isAiCompTutorial,
                );
              },
            ),
          );
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          border: Border.all(color: colorScheme.outline, width: 1.0),
        ),
        height: 60.0,
        child: Text(
          "상품 비교·분석하기",
          textAlign: TextAlign.center,
          style: textTheme.titleLarge!.copyWith(color: colorScheme.onSecondary),
        ),
      ),
    );
  }
}
