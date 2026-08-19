import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/ai_comparison_screen.dart';
import 'package:finbrain/ui/viewModel/text_theme_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/liked_product_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/selected_prdt_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/tutorial_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_appbar.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/product_item.dart';
import 'package:finbrain/ui/widget/search_box.dart';
import 'package:finbrain/ui/widget/showing_error_widget.dart';
import 'package:finbrain/ui/widget/sort_or_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class ProductSelectionScreen extends ConsumerStatefulWidget {
  const ProductSelectionScreen({super.key});
  @override
  ConsumerState<ProductSelectionScreen> createState() =>
      _ProductScelectionScreenState();
}

class _ProductScelectionScreenState
    extends ConsumerState<ProductSelectionScreen> {

  // 튜토리얼을 위한 변수
  // Variables for tutorial
  final List<TargetFocus> targets = [];
  List<FinancialProduct> likedDummies = [];
  GlobalKey key1 = GlobalKey();
  GlobalKey key2 = GlobalKey();
  bool isAiTutorialShown = false;
  bool isFirstDummySelected = false;
  bool isSecondDummySelected = false;
  
  @override
  void initState(){
    super.initState();
    likedDummies = ref
        .read(aiCompTutorialViewmodelProvider.notifier)
        .getMockData();
    setState(() {});
    print("더미 데이터, $likedDummies");
  }

  

  // 튜토리얼 추가하는 함수
  // Add tutorial target
  void initTarget(GlobalKey key, String content, ShapeLightFocus focusShape) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    targets.add(
      TargetFocus(
        identify: key,
        keyTarget: key,
        shape: focusShape,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                content,
                style: textTheme.bodyMedium!.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 튜토리얼 보이기
  void showTutorial() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    TutorialCoachMark(
      targets: targets,
      textSkip: "건너뛰기",
      textStyleSkip: textTheme.bodySmall!.copyWith(
        color: colorScheme.onSurface,
      ),
      pulseEnable: false,
      onFinish: () =>
          ref.read(aiCompTutorialViewmodelProvider.notifier).updatePhase(),
      onSkip: () {
        ref.read(aiCompTutorialViewmodelProvider.notifier).updatePhase();
        return true;
      },
    ).show(context: context);
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

    if (!isAiTutorialShown && ref.read(aiCompTutorialViewmodelProvider) == 3) {
      initTarget(
        key1,
        "체크박스를 통해 원하는 상품을 선택하세요.\n선택한 상품의 카테고리는 반드시 동일해야 합니다",
        ShapeLightFocus.Circle
      );
      initTarget(
        key2,
        "상품 선택 이후 하단의 비교 분석 버튼을 클릭하면 AI가 상품을 비교 분석합니다",
        ShapeLightFocus.RRect
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration(milliseconds: 300), () => showTutorial());
      });
    }

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(screen: "product_selection", title: "상품 선택"),
      ),
      body: Stack(
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
                      child: (!isAiTutorialShown)
                          ? Column(children: [
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        key: key1,
                                        icon: (isFirstDummySelected)
                                            ? Icon(
                                                Icons.check_circle,
                                                color: colorScheme
                                                    .surfaceContainerHigh,
                                                size: 36.0,
                                              )
                                            : Icon(
                                                Icons.circle_outlined,
                                                color: colorScheme.outline,
                                                size: 36.0,
                                              ),
                                        onPressed: () {
                                          setState(() {
                                            isFirstDummySelected = !isFirstDummySelected;
                                          });
                                        },
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: ProductItem(
                                          productCode:
                                              likedDummies[0]
                                                  .commonInfo
                                                  .productCode ??
                                              "isaMp",
                                          productName: likedDummies[0]
                                              .commonInfo
                                              .productName ?? "상품 이름",
                                          category:
                                              likedDummies[0].commonInfo.category,
                                          fromLikedScreen: true,
                                          isSelecting: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16,),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: (isSecondDummySelected)
                                            ? Icon(
                                                Icons.check_circle,
                                                color: colorScheme
                                                    .surfaceContainerHigh,
                                                size: 36.0,
                                              )
                                            : Icon(
                                                Icons.circle_outlined,
                                                color: colorScheme.outline,
                                                size: 36.0,
                                              ),
                                        onPressed: () {
                                          setState(() {
                                            isSecondDummySelected = !isSecondDummySelected;
                                          });
                                        },
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: ProductItem(
                                          productCode:
                                              likedDummies[1]
                                                  .commonInfo
                                                  .productCode ??
                                              "isaMp",
                                          productName: likedDummies[1]
                                              .commonInfo
                                              .productName ?? "상품 이름",
                                          category:
                                              likedDummies[1].commonInfo.category,
                                          fromLikedScreen: true,
                                          isSelecting: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ],
                          )
                          : ListView.builder(
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
                                        icon: (isSelected)
                                            ? Icon(
                                                Icons.check_circle,
                                                color: colorScheme
                                                    .surfaceContainerHigh,
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
                                              data[index]
                                                  .commonInfo
                                                  .productCode ??
                                              "isaMp",
                                          productName: data[index]
                                              .commonInfo
                                              .productName!,
                                          category:
                                              data[index].commonInfo.category,
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
      bottomNavigationBar: navToAiComparisonScreen(
        context,
        ref,
        prdtCodes,
        prdtNames,
      ),
    );
  }

  // 선택된 상품을 갖고 비교 분석 화면으로 이동
  // Navigate to AI comparison screen with selected products
  Widget navToAiComparisonScreen(
    BuildContext context,
    WidgetRef ref,
    String prdtCodes,
    String prdtNames,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return GestureDetector(
      key: key2,
      onTap: () {
        if(!isAiTutorialShown){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => AiComparisonScreen(tag: "", name: "", ctg: ProductCategory.deposit))
          );
        }
        final num = ref
            .read(selectedProductsViewmodelProvider.notifier)
            .getNumOfProducts();
        if (num < 2) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(snackbar(context, "최소 2개 이상의 상품을 선택해주세요!"));
        } else if (!ref
            .read(selectedProductsViewmodelProvider.notifier)
            .allCategoriesSame()) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackbar(context, "선택하신 상품들의 카테고리가 다릅니다!\n동일 카테고리의 상품을 비교해주세요"),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) {
                final ctg = ref
                    .read(selectedProductsViewmodelProvider.notifier)
                    .getCategory();
                if (ctg == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    snackbar(context, "선택하신 상품의 카테고리가 존재하지 않습니다.\n다시 시도해주세요"),
                  );
                  return const SizedBox.shrink();
                }
                return AiComparisonScreen(
                  tag: prdtCodes,
                  name: prdtNames,
                  ctg: ctg,
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

  SnackBar snackbar(BuildContext context, String text) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SnackBar(
      backgroundColor: colorScheme.scrim,
      duration: const Duration(seconds: 3),
      content: Text(
        text,
        style: textTheme.bodySmall!.copyWith(color: colorScheme.onSecondary),
      ),
    );
  }
}
