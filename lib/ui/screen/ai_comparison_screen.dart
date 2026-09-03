import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/main_screen.dart';
import 'package:finbrain/ui/screen/my_page_screen.dart';
import 'package:finbrain/ui/tutorial_helper.dart';
import 'package:finbrain/ui/viewmodel/ai_response_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/selected_prdt_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/text_theme_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/ai_comp_tutorial_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_appbar.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/custom_text.dart';
import 'package:finbrain/ui/widget/markdown_text_render.dart';
import 'package:finbrain/ui/widget/showing_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

// AI 비교분석 스크린
// Displaying comparison text screen
class AiComparisonScreen extends ConsumerStatefulWidget {
  const AiComparisonScreen({
    super.key,
    required this.tag,
    required this.name,
    required this.ctg,
    this.isAiCompTutorial,
  });

  final String tag; // 상품 코드나 이름 묶음(collection of product codes or names)
  final String name; // 상품 이름 묶음(collection of product names)
  final ProductCategory ctg; // 상품 카테고리(product category)
  final bool? isAiCompTutorial;

  @override
  ConsumerState<AiComparisonScreen> createState() => _AiComparisonScreenState();
}

class _AiComparisonScreenState extends ConsumerState<AiComparisonScreen> {
  // 튜토리얼을 위한 변수
  // Variables for tutorial
  final List<TargetFocus> targets = [];
  GlobalKey aiCompkey5 = GlobalKey();
  bool isAiTutorialShown = true;

  @override
  void initState() {
    super.initState();
    ref.read(aiCompTutorialViewmodelProvider.future).then((value) {
      if (value == false) {
        isAiTutorialShown = false;
        _showAiCompTutorial();
      }
    });
  }

  void _showAiCompTutorial() {
    initTarget(
      context,
      targets,
      aiCompkey5,
      ContentAlign.top,
      ShapeLightFocus.RRect,
      "저장하기 버튼을 통해 AI 비교 분석을 저장할 수 있습니다\n\n저장 내역은 마이페이지 > 기록 저장소에서 확인 가능합니다",
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 이 분석 저장하기 위치로 이동 후 튜토리얼 보이기
      // Show tutorial after moving to "save response button"
      final keyContext = aiCompkey5.currentContext;
      if (keyContext != null) {
        Scrollable.ensureVisible(
          keyContext,
          duration: const Duration(milliseconds: 300),
          alignment: 0.5,
        ).then((_) {
          Future.delayed(
            Duration(milliseconds: 300),
            () => showTutorial(context, targets, () {
              ref
                  .read(aiCompTutorialViewmodelProvider.notifier)
                  .setReadAiCompTutorialToValue(true);
              // 변경된 상태를 반영하기 위해 invalidate
              // Invalidate provider to apply changed state
              ref.invalidate(aiCompTutorialViewmodelProvider);
            }),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    // 상품 이름을 분리
    // Separate name collection
    final items = widget.name.split("`");
    // AI 프롬프트(AI prompt)
    final request = "$items들의 공통점과 차이점을 바탕으로 표 없이 비교 분석해줘";

    // 프롬프트 전달
    // Send AI prompt
    final text = ref.watch(aiComparisonScreenViewmodelProvider(request));

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(screen: "ai_comp", title: "AI 비교 분석"),
      ),
      body: text.when(
        data: (data) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 20.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    // AI 응답
                    // AI Comparison texts(response)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: MarkdownTextRenderer(str: data),
                    ),
                    CustomText(
                      text: "*AI 응답 특성 상 일부 잘못되거나 최신 정보를 포함하지 않을 수 있습니다",
                      style: textTheme.bodySmall!.copyWith(
                        color: colorScheme.onTertiary,
                      ),
                    ),
                    const SizedBox(height: 16.0,),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            // 재생성(refresh)
                            ref
                                .read(
                                  aiComparisonScreenViewmodelProvider(
                                    request,
                                  ).notifier,
                                )
                                .refreshComparison(request);
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              colorScheme.secondary,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "다시 생성하기",
                              style: textTheme.bodyMedium!.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        GestureDetector(
                          onTap: () async {
                            if (isAiTutorialShown) {
                              // 서버에 응답 저장
                              // Save AI response in firestore
                              await ref
                                  .read(
                                    aiComparisonScreenViewmodelProvider(
                                      request,
                                    ).notifier,
                                  )
                                  .saveComparisonText(
                                    widget.name,
                                    widget.tag,
                                    widget.ctg,
                                  );
                            }
                            // 선택 상품 리스트 초기화
                            // Reset selected products list
                            ref
                                .read(
                                  selectedProductsViewmodelProvider.notifier,
                                )
                                .resetSelectedList();
                            if (context.mounted) {
                              // 관심 상품 화면으로 이동
                              // Navigate to Liked Screen
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (ctx) =>
                                      (widget.isAiCompTutorial == true)
                                      ? const MyPageScreen()
                                      : const MainScreen(index: 2),
                                ),
                                (route) => false,
                              );
                            }
                          },
                          child: Container(
                            key: aiCompkey5,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  colorScheme.surfaceContainerLowest,
                                  colorScheme.surfaceContainerLow,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "이 분석 저장하기",
                              style: textTheme.titleMedium!.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          );
        },
        error: (error, stack) => Column(
          children: [
            const Expanded(child: ShowingErrorWidget()),
            const SizedBox(width: 16.0),
            TextButton(
              onPressed: () {
                // 오류 발생 시 재시도
                // Try again to fetch response when error occurred
                ref
                    .read(
                      aiComparisonScreenViewmodelProvider(widget.tag).notifier,
                    )
                    .refreshComparison(request);
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(colorScheme.secondary),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "다시 생성하기",
                  style: textTheme.bodyMedium!.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
        loading: () => const CustomProgressIndicator(),
      ),
    );
  }
}
