import 'package:finbrain/ui/screen/product_selection_screen.dart';
import 'package:finbrain/ui/viewmodel/liked_product_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewmodel/tutorial_viewmodel.dart';
import 'package:finbrain/ui/widget/ai_button.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/showing_error_widget.dart';
import 'package:finbrain/ui/widget/sort_or_filter.dart';
import 'package:finbrain/ui/widget/product_item.dart';
import 'package:finbrain/ui/widget/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

// 관심 상품 리스트
class LikedScreen extends ConsumerStatefulWidget {
  const LikedScreen({super.key});
  
  @override
  ConsumerState<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends ConsumerState<LikedScreen> {
  // 튜토리얼을 위한 변수
  // Variables for tutorial
  GlobalKey key = GlobalKey();
  bool isAiTutorialShown = false;

  // 튜토리얼 보이기
  void showTutorial() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    TutorialCoachMark(
      targets: [
        TargetFocus(
          identify: key,
          keyTarget: key,
          shape: ShapeLightFocus.Circle,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.secondary,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Text(
                  "관심 상품을 확인하세요\n하단 메뉴에서 관심 설정한 금융 상품을 한 눈에 볼 수 있습니다",
                  style: textTheme.bodyMedium!.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
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
    // 관심 상품 관찰하기
    // Watch liked products
    final liked = ref.watch(likedProductViewmodelProvider);
    final likedDummies = ref.read(aiCompTutorialViewmodelProvider.notifier).getMockData();

    if (!isAiTutorialShown && ref.read(aiCompTutorialViewmodelProvider) == 2) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(
          Duration(milliseconds: 300),
          () => showTutorial(),
        );
      });
    }

    return Padding(
      padding: const EdgeInsets.only(
        top: 24.0,
        left: 20.0,
        right: 20.0,
        bottom: 20.0,
      ),
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
                child: Stack(
                  children: [
                    if (liked.value != null)
                      Positioned.fill(
                        child: ListView.builder(
                          itemCount: (isAiTutorialShown) ? liked.value!.length: likedDummies.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: ProductItem(
                                productCode:
                                    ((isAiTutorialShown) ? data : likedDummies)[index].commonInfo.productCode ??
                                    "isaMp",
                                productName:
                                    ((isAiTutorialShown) ? data : likedDummies)[index].commonInfo.productName!,
                                category: ((isAiTutorialShown) ? data : likedDummies)[index].commonInfo.category,
                                fromLikedScreen: true,
                                isSelecting: false,
                              ),
                            );
                          },
                        ),
                      ),
                    // 비교 분석 AI 버튼
                    // AI button for comparison
                    Positioned(
                      key: key,
                      right: 5,
                      bottom: 5,
                      child: AiButton(
                        tag: null,
                        name: null,
                        category: ProductCategory.liked,
                        isBtnClicked: () {
                          // 상품 선택 스크린으로 이동
                          // Navigate to product selection screen
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => ProductSelectionScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => const Expanded(child: CustomProgressIndicator()),
            error: (error, stackTrace) =>
                const Expanded(child: ShowingErrorWidget()),
          ),
        ],
      ),
    );
  }
}
