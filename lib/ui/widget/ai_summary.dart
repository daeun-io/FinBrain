import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/ui/widget/markdown_text_render.dart';
import 'package:flutter/material.dart';

class AiSummary extends StatelessWidget {
  const AiSummary({super.key, required this.texts});

  final List<AiText> texts;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: texts.map((e) => _buildSingleSummary(context, e.text, colorScheme)).toList(),
    );
  }

  Widget _buildSingleSummary(BuildContext context, String text, ColorScheme colorScheme) {
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
              gradient: LinearGradient(colors: [
                colorScheme.surfaceContainerLowest,
                colorScheme.surfaceContainerLow
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight
              ),
              borderRadius: BorderRadiusGeometry.all(Radius.circular(20.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "지난 대화 요약",
                      style: TextStyle(
                        color: colorScheme.onSecondary,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  MarkdownTextRenderer(str: text)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
