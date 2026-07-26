import 'package:finbrain/ui/widget/ai_request.dart';
import 'package:finbrain/ui/widget/markdown_text_render.dart';
import 'package:flutter/material.dart';

// AI 어시스트 화면 대화 버블
// AI assist screen chat bubbles
class MessageBubble extends StatelessWidget {
  
  const MessageBubble({super.key, required this.isUser, required this.text});

  final bool isUser;        // 대화 대상 (who is talking)
  final String text;        // 대화 텍스트

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      // 대화 대상에 따라 위치 및 텍스트 스타일 변경
      // Change position and text style based on talker
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: isUser ? AiRequest(text: text) : MarkdownTextRenderer(str: text),
      ),
    );
  }
}
