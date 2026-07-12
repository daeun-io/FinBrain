import 'package:finbrain/ui/widget/ai_request.dart';
import 'package:finbrain/ui/widget/markdown_text_render.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  
  const MessageBubble({super.key, required this.isUser, required this.text});

  final bool isUser;
  final String text;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: isUser ? AiRequest(text: text) : MarkdownTextRenderer(str: text),
      ),
    );
  }
}
