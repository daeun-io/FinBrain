import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewmodel/ai_response_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/text_theme_viewmodel.dart';
import 'package:finbrain/ui/widget/ai_example_query.dart';
import 'package:finbrain/ui/widget/ai_summary.dart';
import 'package:finbrain/ui/widget/custom_appbar.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// AI 어시스트 스크린(AI 채팅)
// AI assist screen(chat window)
class AiAssistScreen extends ConsumerStatefulWidget {
  const AiAssistScreen({
    super.key,
    required this.tag,
    required this.category,
    required this.name,
  });

  final String tag; // 상품 코드나 이름(product code or name)
  final ProductCategory category; // 상품 카테고리(product category)
  final String name; // 상품 이름(product name)

  @override
  ConsumerState<AiAssistScreen> createState() => _AiAssistScreenState();
}

class _AiAssistScreenState extends ConsumerState<AiAssistScreen> {
  final _messageController = TextEditingController();
  AiRecord? record; // AI 요약(AI summaries)
  List<(MessageBubble, MessageBubble)>?
  messages; // 대화 내역(chat history in firestore)

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
      // 서버에 저장된 이전 대화 가져오기
      // Fetch chat histories from firestore
      messages = await ref
          .read(aiAssistScreenViewmodelProvider(widget.tag).notifier)
          .getConversationWithPrdtNmOrCd(widget.tag);
    } catch (e) {
      debugPrint("[error] failed to fetch messages(chat_history): $e");
    }
  }

  Future<void> _getSummaries() async {
    try {
      // AI 요약 가져오기
      // Fetch AI summaries from firestore
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
    final textTheme = ref.watch(textThemeViewmodelProvider);

    // 현재 나누고 있는 대화
    // Current chats
    List<String> bubbles = ref.watch(
      aiAssistScreenViewmodelProvider(widget.tag),
    );
    print("상품, ${widget.tag}");
    print("record, ${record?.key}");
    print("message, ${messages?.isEmpty}");
    print("bubbles, ${bubbles.isEmpty}");
    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(screen: "ai_assist", title: "AI 어시스트"),
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
                          // AI 요약 최상단에
                          // Show AI summaries at the top
                          if (record!.key.isNotEmpty)
                            SliverToBoxAdapter(
                              child: AiSummary(texts: record!.value),
                            ),
                          // 기존 대화 내역
                          // Show existing chats
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
                          // 현재 나누고 있는 대화
                          // Show current chats
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
                          // 만약 첫 대화라면 질문 예시 디스플레이
                          // If this is first conversation, display example queries
                          if (bubbles.isEmpty &&
                              (record == null || record!.key.isEmpty) &&
                              (messages == null || messages!.isEmpty))
                            SliverFillRemaining(
                              hasScrollBody: false,
                              fillOverscroll: false,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    AiExampleQuery(
                                      query: "상품에 대해 자세히 설명해줘",
                                      tapFunc: () => setState(() {
                                        processAiRequest(
                                          ref,
                                          "상품에 대해 자세히 설명해줘",
                                        );
                                      }),
                                    ),
                                    const SizedBox(height: 8.0),
                                    AiExampleQuery(
                                      query: "관련 금융 용어의 정의를 설명해줘",
                                      tapFunc: () => setState(() {
                                        processAiRequest(
                                          ref,
                                          "관련 금융 용어의 정의를 설명해줘",
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  // 대화 입력창
                  // Chat input
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
                                    processAiRequest(ref, request);
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
                                processAiRequest(ref, request);
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

  // 입력 저장하고 대화 불러오기
  // Fetch AI response based on input and save in firestore
  void processAiRequest(WidgetRef ref, String request) {
    ref
        .read(aiAssistScreenViewmodelProvider(widget.tag).notifier)
        .saveRequest(request);
    ref
        .read(aiAssistScreenViewmodelProvider(widget.tag).notifier)
        .fetchResponseAndSaveConv(
          request,
          widget.tag,
          widget.category,
          widget.name,
        );
  }
}
