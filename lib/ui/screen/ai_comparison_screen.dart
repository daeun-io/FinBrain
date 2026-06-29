import 'package:finbrain/data/viewModel/ai_response_viewmodel.dart';
import 'package:finbrain/data/viewModel/selected_prdt_viewmodel.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AiComparisonScreen extends ConsumerWidget {
  const AiComparisonScreen({super.key, required this.tag});

  final String tag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = tag.split('-');
    items.remove("compare");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(aiComparisonScreenViewmodelProvider(tag).notifier)
          .askComparsion("$items를 비교 분석하고 내용을 표로 정리해줘");
    });

    final text = ref.watch(aiComparisonScreenViewmodelProvider(tag));

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary100,
        scrolledUnderElevation: 0.0,
        title: const Text(
          "AI 비교 분석",
          style: TextStyle(
            color: textPrimary,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        titleSpacing: -6.0,
      ),
      body: (text.isEmpty)
          ? Center(child: const CircularProgressIndicator(color: primary400))
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
                          color: black,
                          fontSize: 12.0,
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
                                    tag,
                                  ).notifier,
                                )
                                .askComparsion("$items를 비교 분석하고 내용을 표로 정리해줘");
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Color(0xfff4f4f4),
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
                        TextButton(
                          onPressed: () {
                            // todo: save in db
                            ref
                                .read(
                                  selectedProductsViewmodelProvider.notifier,
                                )
                                .resetSelectedList();
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(primary400),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "이 분석 저장하기",
                              style: TextStyle(
                                color: textPrimary,
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
