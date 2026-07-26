import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/ui/viewmodel/text_theme_viewmodel.dart';
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
      children: texts
          .map(
            (e) => _buildSingleSummary(
              context,
              e.text,
              colorScheme,
              textTheme.headlineMedium!,
            ),
          )
          .toList(),
    );
  }

  Widget _buildSingleSummary(
    BuildContext context,
    String text,
    ColorScheme colorScheme,
    TextStyle style,
  ) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 0,
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
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
              borderRadius: BorderRadiusGeometry.all(Radius.circular(20.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "지난 대화 요약",
                      style: style.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  MarkdownTextRenderer(str: text),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
