import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:flutter/material.dart';

class AiSummary extends StatelessWidget {
  const AiSummary({super.key, required this.texts});

  final List<AiText> texts;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: texts.map((e) => _buildSingleSummary(context, e.text)).toList(),
    );
  }

  Widget _buildSingleSummary(BuildContext context, String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 0,
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Card(
          color: primary100,
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: primary300, width: 1.0),
            borderRadius: BorderRadiusGeometry.all(Radius.circular(20.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            child: Column(
              children: [
                const Text(
                  "지난 대화 요약",
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  text,
                  style: TextStyle(
                    color: black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
