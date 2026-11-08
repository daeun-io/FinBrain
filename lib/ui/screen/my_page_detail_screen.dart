import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/main_screen.dart';
import 'package:finbrain/ui/screen/product_detail_screen.dart';
import 'package:finbrain/ui/viewModel/text_theme_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/ai_comp_tutorial_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/my_page_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPageDetailScreen extends ConsumerStatefulWidget {
  final String title;
  final String? content;
  const MyPageDetailScreen({super.key, required this.title, this.content});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyPageDetailScreenState();
}

class _MyPageDetailScreenState extends ConsumerState<MyPageDetailScreen> {
  late List<dynamic> _items;
  late int _selectedToneIndex;
  bool _isLoading = true;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final fetched = switch (widget.title) {
        "앱 튜토리얼 다시보기" => ["상세 화면 및 AI 채팅", "ISA", "AI 비교 분석"],
        "공지사항" =>
          await ref.read(myPageViewmodelProvider.notifier).fetchNotices(),
        "AI 어조 설정" => ["설명적으로", "간결하게", "전문적으로", "사용자 지정"],
        _ => [],
      };

      final tone = await ref.read(myPageViewmodelProvider.notifier).getAiTone();

      if (mounted) {
        setState(() {
          _items = fetched;
          _selectedToneIndex = _items.contains(tone) ? _items.indexOf(tone) : 3;
          _controller.text = (tone == null || _selectedToneIndex != 3)
              ? ""
              : tone;
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _saveToneOrShowDialog(BuildContext context, WidgetRef ref) async {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    if (widget.title == "AI 어조 설정") {
      if (_selectedToneIndex == 3 && _controller.text.isEmpty) {
        final bool? shouldPop = await showDialog<bool>(
          context: Navigator.of(context, rootNavigator: true).context,
          builder: (context) => AlertDialog(
            backgroundColor: colorScheme.surfaceContainer,
            title: CustomText(
              text: "AI 어조가 설정되지 않았습니다",
              style: textTheme.bodyMedium!.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
            content: CustomText(
              text: "다시 설정하시겠습니까?",
              style: textTheme.titleMedium!.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: CustomText(
                  text: "아니오",
                  style: textTheme.bodyMedium!.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: CustomText(
                  text: "예",
                  style: textTheme.bodyMedium!.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ),
            ],
          ),
        );
        if (shouldPop == true) {
          if (!context.mounted) return;
          Navigator.of(context).pop();
        }
      } else {
        ref
            .read(myPageViewmodelProvider.notifier)
            .setAiTone(
              (_selectedToneIndex == 3)
                  ? _controller.text
                  : _items[_selectedToneIndex],
            );
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        _saveToneOrShowDialog(context, ref);
      },
      child: Scaffold(
        backgroundColor: colorScheme.primary,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            backgroundColor: colorScheme.tertiary,
            title: CustomText(
              text: !["앱 튜토리얼 다시보기", "공지사항", "AI 어조 설정"].contains(widget.title)
                  ? "공지사항"
                  : widget.title,
              style: textTheme.headlineMedium!.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
            leading: IconButton(
              onPressed: () async {
                _saveToneOrShowDialog(context, ref);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: (_isLoading)
              ? CustomProgressIndicator()
              : (!["앱 튜토리얼 다시보기", "공지사항", "AI 어조 설정"].contains(widget.title))
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: widget.title,
                      style: textTheme.headlineSmall!.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomText(
                      text: widget.content ?? "",
                      style: textTheme.bodyMedium!.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) => switch (widget.title) {
                    "앱 튜토리얼 다시보기" => TutorialListTile(
                      context,
                      ref,
                      _items[index],
                    ),
                    "공지사항" => NoticeListTile(
                      context,
                      ref,
                      _items[index].title,
                      _items[index].content,
                    ),
                    "AI 어조 설정" => AiToneListTile(
                      context,
                      _controller,
                      _items[index],
                      index,
                    ),
                    _ => const ListTile(),
                  },
                ),
        ),
      ),
    );
  }

  Widget TutorialListTile(BuildContext context, WidgetRef ref, String title) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return GestureDetector(
      onTap: () {
        if (title == "AI 비교 분석") {
          ref
              .read(aiCompTutorialViewmodelProvider.notifier)
              .setReadAiCompTutorialToValue(false);
          // 변경된 상태를 반영하기 위해 invalidate
          // Invalidate provider to apply changed state
          ref.invalidate(aiCompTutorialViewmodelProvider);
        }
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) {
              switch (title) {
                case "상세 화면 및 AI 채팅":
                  return const ProductDetailScreen(
                    productCode: "tutorial",
                    productName: "우리웰리치 주거래예금",
                    category: ProductCategory.deposit,
                    fromLikedScreen: false,
                    isTutorial: true,
                  );
                case "ISA":
                  return const MainScreen(isIsaTutorial: true);
                default:
                  return const MainScreen(isAiCompTutorial: true);
              }
            },
          ),
        );
      },
      child: ListTile(
        title: CustomText(
          text: title,
          style: textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: colorScheme.onSecondary,
        ),
      ),
    );
  }

  Widget NoticeListTile(
    BuildContext context,
    WidgetRef ref,
    String title,
    String content,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) =>
                MyPageDetailScreen(title: title, content: content),
          ),
        );
      },
      child: ListTile(
        title: CustomText(
          text: title,
          style: textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary),
        ),
        leading: Icon(
          Icons.campaign_outlined,
          size: 24,
          color: colorScheme.onSecondary,
        ),
      ),
    );
  }

  Widget AiToneListTile(
    BuildContext context,
    TextEditingController controller,
    String title,
    int index,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return Column(
      children: [
        Row(
          children: [
            CustomText(
              text: title,
              style: textTheme.bodyMedium!.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedToneIndex = index;
                });
              },
              icon: Icon(
                (_selectedToneIndex == index)
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                size: 24.0,
                color: (_selectedToneIndex == index)
                    ? colorScheme.onTertiaryFixed
                    : colorScheme.outline,
              ),
            ),
          ],
        ),
        if (_selectedToneIndex == 3 && index == 3) ...[
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            maxLines: 5,
            decoration: InputDecoration(
              filled: true,
              fillColor: colorScheme.secondary,
              border: InputBorder.none,
              hintText:
                  "차근차근 설명해주세요. 복잡한 내용도 쉽게 이해하도록 예시를 들어가며 단계별로 풀어서 설명해주세요.",
              hintStyle: textTheme.bodyMedium!.copyWith(
                color: colorScheme.onTertiary,
              ),
            ),
            style: textTheme.bodyMedium!.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
