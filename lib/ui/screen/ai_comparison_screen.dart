import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewmodel/ai_response_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/selected_prdt_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_appbar.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/markdown_text_render.dart';
import 'package:finbrain/ui/widget/showing_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// AI 비교분석 스크린
// Displaying comparison text screen
class AiComparisonScreen extends ConsumerStatefulWidget {
  const AiComparisonScreen({
    super.key,
    required this.tag, 
    required this.name,
    required this.ctg,
  });

  final String tag;             // 상품 코드나 이름 묶음(collection of product codes or names)
  final String name;            // 상품 이름 묶음(collection of product names)
  final ProductCategory ctg;    // 상품 카테고리(product category)

  @override
  ConsumerState<AiComparisonScreen> createState() => _AiComparisonScreenState();
}

class _AiComparisonScreenState extends ConsumerState<AiComparisonScreen> {
  late List<String> items;

  late String request;

  @override
  void initState() {
    super.initState();
    // 상품 이름을 분리
    // Separate name collection
    items = widget.name.split("`");
    // AI 프롬프트(AI prompt)
    request = "$items들의 공통점과 차이점을 바탕으로 표 없이 비교 분석해줘";
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            // 재생성(refresh)
                            ref
                                .read(
                                  aiComparisonScreenViewmodelProvider(
                                    widget.tag,
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
                            padding: const EdgeInsets.all(4.0),
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
                            // 비교 대상 초기화
                            // Reset the comparison target list
                            ref
                                .read(
                                  selectedProductsViewmodelProvider.notifier,
                                )
                                .resetSelectedList();
                            // 서버에 응답 저장
                            // Save AI response in firestore
                           await ref
                                .read(
                                  aiComparisonScreenViewmodelProvider(
                                    request,
                                  ).notifier,
                                )
                                .saveComparisonText(widget.name, widget.tag, widget.ctg);
                            if(context.mounted){
                              Navigator.of(context).pop();
                            }
                          },
                          child: Container(
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
