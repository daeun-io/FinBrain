import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewmodel/ai_response_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/selected_prdt_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/markdown_text_render.dart';
import 'package:finbrain/ui/widget/showing_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AiComparisonScreen extends ConsumerStatefulWidget {
  const AiComparisonScreen({
    super.key,
    required this.tag,
    required this.name,
    required this.ctg,
  });

  final String tag;
  final String name;
  final ProductCategory ctg;

  @override
  ConsumerState<AiComparisonScreen> createState() => _AiComparisonScreenState();
}

class _AiComparisonScreenState extends ConsumerState<AiComparisonScreen> {
  late List<String> items;

  late String request;

  @override
  void initState() {
    super.initState();
    items = widget.name.split("`");
    request = "$items들의 공통점과 차이점을 바탕으로 표 없이 비교 분석해줘";
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final text = ref.watch(aiComparisonScreenViewmodelProvider(request));

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: AppBar(
        backgroundColor: colorScheme.tertiary,
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new, color: colorScheme.onPrimary),
        ),
        title: Text(
          "AI 비교 분석",
          style: textTheme.headlineMedium!.copyWith(
            color: colorScheme.onPrimary,
          ),
        ),
        titleSpacing: -6.0,
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: MarkdownTextRenderer(str: data),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
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
                            ref
                                .read(
                                  selectedProductsViewmodelProvider.notifier,
                                )
                                .resetSelectedList();
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
