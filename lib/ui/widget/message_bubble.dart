import 'package:finbrain/themes/text_style.dart';
import 'package:finbrain/ui/widget/ai_request.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  // todo: implement for AiSummary
  const MessageBubble({super.key, required this.isUser, required this.text});

  final bool isUser;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: isUser
            ? AiRequest(text: text)
            : Text(
                text,
                style: bodyRgMd.copyWith(color: colorScheme.onSecondary)
              ),
      ),
    );
  }
}
