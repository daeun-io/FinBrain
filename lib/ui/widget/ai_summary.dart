import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/ui/viewmodel/text_theme_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_text.dart';
import 'package:finbrain/ui/widget/markdown_text_render.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// AI 도우미 스크린 대화 요약
// AI summaries in assist screen
class AiSummary extends ConsumerWidget {
  const AiSummary({super.key, required this.texts});

  final List<AiText> texts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: CustomText(
              text: "지난 대화 요약",
              style: textTheme.titleMedium!.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        ...texts.map(
          (e) => _buildSingleSummary(context, e, colorScheme, textTheme),
        ),
      ],
    );
  }

  Widget _buildSingleSummary(
    BuildContext context,
    AiText text,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Column(
      children: [
        CustomText(
          text: text.createdAt.toIso8601String().split("T").first,
          style: textTheme.titleSmall!.copyWith(color: colorScheme.onTertiary),
        ),
        MarkdownTextRenderer(str: text.text),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
