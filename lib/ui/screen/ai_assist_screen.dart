import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewmodel/ai_response_viewmodel.dart';
import 'package:finbrain/ui/widget/ai_summary.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AiAssistScreen extends ConsumerStatefulWidget {
  const AiAssistScreen({super.key, required this.tag, required this.category, required this.name});

  final String tag;
  final ProductCategory category;
  final String name;

  @override
  ConsumerState<AiAssistScreen> createState() => _AiAssistScreenState();
}

class _AiAssistScreenState extends ConsumerState<AiAssistScreen> {
  final _messageController = TextEditingController();
  AiRecord? record;
  List<(MessageBubble, MessageBubble)>? messages;

  @override
  void initState() {
    super.initState();
    _initializeMessages();
    _getSummaries();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _initializeMessages() async {
    try {
      messages = await ref
          .read(aiAssistScreenViewmodelProvider(widget.tag).notifier)
          .getConversationWithPrdtNmOrCd(widget.tag);
    } catch (e) {
      debugPrint("[error] failed to fetch messages(chat_history): $e");
    }
  }

  Future<void> _getSummaries() async {
    try {
      final result = await ref
          .read(aiAssistScreenViewmodelProvider(widget.tag).notifier)
          .getSummariesWithPrdtNmOrCd(widget.tag);
      setState(() {
        record = result;
      });
    } catch (e) {
      debugPrint("[error] failed to fetch summaries: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isPhone = MediaQuery.of(context).size.width < 600;
    List<String> bubbles = ref.watch(
      aiAssistScreenViewmodelProvider(widget.tag),
    );

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: AppBar(
        backgroundColor: colorScheme.tertiary,
        scrolledUnderElevation: 0.0,
        leading: (isPhone)
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: colorScheme.onPrimary,
                ),
              )
            : null,
        automaticallyImplyLeading: false,
        title: Text(
          "AI 어시스트",
          style: textTheme.headlineMedium!.copyWith(
            color: colorScheme.onPrimary,
          ),
        ),
        titleSpacing: (isPhone) ? -6.0 : 24.0,
      ),
      body: (record == null)
          ? const CustomProgressIndicator()
          : SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 24.0,
                        left: 20.0,
                        right: 20.0,
                        bottom: 20.0,
                      ),
                      child: CustomScrollView(
                        slivers: [
                          if (record!.key.isNotEmpty)
                            SliverToBoxAdapter(
                              child: AiSummary(texts: record!.value),
                            ),
                          if (messages != null && messages!.isNotEmpty)
                            SliverList.builder(
                              itemCount: messages!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                  ),
                                  child: Column(
                                    children: [
                                      messages![index].$1,
                                      messages![index].$2,
                                    ],
                                  ),
                                );
                              },
                            ),
                          if (bubbles.isNotEmpty)
                            SliverList.builder(
                              itemCount: bubbles.length,
                              itemBuilder: (context, index) {
                                if (bubbles[index] == "loading") {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: CustomProgressIndicator(),
                                  );
                                }
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                  ),
                                  child: MessageBubble(
                                    isUser: (index % 2 == 0) ? true : false,
                                    text: bubbles[index],
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      color: colorScheme.tertiary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _messageController,
                                onSubmitted: (value) async {
                                  if (value.isNotEmpty) {
                                    final request = value;
                                    _messageController.clear();
                                    ref
                                        .read(
                                          aiAssistScreenViewmodelProvider(
                                            widget.tag,
                                          ).notifier,
                                        )
                                        .saveRequest(request);
                                    ref
                                        .read(
                                          aiAssistScreenViewmodelProvider(
                                            widget.tag,
                                          ).notifier,
                                        )
                                        .fetchResponseAndSaveConv(
                                          request,
                                          widget.tag,
                                          widget.category,
                                          widget.name,
                                        );
                                  }
                                },
                                maxLines: null,
                                style: textTheme.bodyMedium!.copyWith(
                                  color: colorScheme.onSecondary,
                                ),
                                decoration: InputDecoration(
                                  hintText: "AI한테 질문하기",
                                  hintStyle: textTheme.bodyMedium!.copyWith(
                                    color: colorScheme.onTertiary,
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
                            onPressed: () async {
                              if (_messageController.text.isNotEmpty) {
                                final request = _messageController.text;
                                _messageController.clear();
                                ref
                                    .read(
                                      aiAssistScreenViewmodelProvider(
                                        widget.tag,
                                      ).notifier,
                                    )
                                    .saveRequest(request);
                                ref
                                    .read(
                                      aiAssistScreenViewmodelProvider(
                                        widget.tag,
                                      ).notifier,
                                    )
                                    .fetchResponseAndSaveConv(
                                      request,
                                      widget.tag,
                                      widget.category,
                                      widget.name,
                                    );
                              }
                            },
                            icon: Icon(
                              Icons.send,
                              color: colorScheme.surfaceContainerHighest,
                              size: 28.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
