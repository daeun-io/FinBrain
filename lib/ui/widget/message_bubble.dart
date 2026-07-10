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
                style: TextStyle(
                  color: colorScheme.onSecondary,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
      ),
    );
  }
}
