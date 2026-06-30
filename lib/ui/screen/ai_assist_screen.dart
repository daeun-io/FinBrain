import 'package:finbrain/data/viewModel/ai_response_viewmodel.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/widget/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AiAssistScreen extends ConsumerWidget {
  AiAssistScreen({super.key, required this.tag});

  final String tag;
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FocusNode mFocusNode = FocusNode();
    Map<String, String> aiMessages = ref.watch(aiScreenViewmodelProvider(tag));

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary100,
        scrolledUnderElevation: 0.0,
        title: const Text(
          "AI 어시스트",
          style: TextStyle(
            color: textPrimary,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        titleSpacing: -6.0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 24.0),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: aiMessages.length,
              itemBuilder: (context, index) {
                final entry = aiMessages.entries.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Column(
                    children: [
                      MessageBubble(isUser: true, text: entry.key),
                      (entry.value.isEmpty)
                          ? const CircularProgressIndicator(color: primary400)
                          : MessageBubble(isUser: false, text: entry.value),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: primary100,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _messageController,
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            ref
                                .read(aiScreenViewmodelProvider(tag).notifier)
                                .addRequest(value, tag);
                            _messageController.clear();
                            mFocusNode.unfocus();
                          }
                        },
                        onTap: () {
                          mFocusNode.requestFocus();
                          SystemChannels.textInput.invokeMethod(
                            'TextInput.show',
                          );
                        },
                        focusNode: mFocusNode,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: "AI한테 질문하기",
                          hintStyle: TextStyle(
                            color: textSecondary,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_messageController.text.isNotEmpty) {
                        ref
                            .read(aiScreenViewmodelProvider(tag).notifier)
                            .addRequest(_messageController.text, tag);
                        _messageController.clear();
                        mFocusNode.unfocus();
                      }
                    },
                    icon: SvgPicture.asset(
                      "assets/images/send_icon.svg",
                      width: 42,
                      height: 42,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
