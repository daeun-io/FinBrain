import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewmodel/ai_response_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/selected_prdt_viewmodel.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AiComparisonScreen extends ConsumerStatefulWidget {
  const AiComparisonScreen({super.key, required this.tag, required this.ctg});

  final String tag;
  final ProductCategory ctg;

  @override
  ConsumerState<AiComparisonScreen> createState() => _AiComparisonScreenState();
}

class _AiComparisonScreenState extends ConsumerState<AiComparisonScreen> {
  late List<String> items;

  @override
  void initState() {
    super.initState();
    items = widget.tag.split("-");
    items.remove("compare");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(aiComparisonScreenViewmodelProvider(widget.tag).notifier)
          .askComparsion("$items를 비교 분석하고 내용을 표로 정리해줘");
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final text = ref.watch(aiComparisonScreenViewmodelProvider(widget.tag));

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
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        titleSpacing: -6.0,
      ),
      body: (text.isEmpty)
          ? const CustomProgressIndicator()
          : Padding(
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
                      child: Text(
                        text,
                        style: TextStyle(
                          color: colorScheme.onSecondary,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
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
                                .askComparsion("$items를 비교 분석하고 내용을 표로 정리해줘");
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
                              style: TextStyle(
                                color: black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        GestureDetector(
                          onTap: () {
                            ref
                                .read(
                                  selectedProductsViewmodelProvider.notifier,
                                )
                                .resetSelectedList();
                            ref
                                .read(
                                  aiComparisonScreenViewmodelProvider(
                                    widget.tag,
                                  ).notifier,
                                )
                                .saveComparisonText(widget.ctg);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  colorScheme.surfaceContainerLowest,
                                  colorScheme.surfaceContainerLow,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight
                              ),
                            ),
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "이 분석 저장하기",
                              style: TextStyle(
                                color: colorScheme.onPrimary,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
