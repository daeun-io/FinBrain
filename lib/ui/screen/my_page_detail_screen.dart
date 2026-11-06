import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/main_screen.dart';
import 'package:finbrain/ui/screen/product_detail_screen.dart';
import 'package:finbrain/ui/viewModel/text_theme_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/ai_comp_tutorial_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/my_page_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_appbar.dart';
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
  late List<dynamic> items;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final fetched = switch (widget.title) {
        "앱 튜토리얼 다시보기" => ["상세 화면 및 AI 채팅", "ISA", "AI 비교 분석"],
        "공지사항" =>
          await ref.read(myPageViewmodelProvider.notifier).fetchNotices(),
        "AI 설정" => [],
        _ => [],
      };

      if (mounted) {
        setState(() {
          items = fetched;
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          screen: "my_page_detail",
          title: !["앱 튜토리얼 다시보기", "공지사항"].contains(widget.title)
              ? "공지사항"
              : widget.title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: (isLoading)
            ? CustomProgressIndicator()
            : (!["앱 튜토리얼 다시보기", "공지사항"].contains(widget.title))
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
                itemCount: items.length,
                itemBuilder: (context, index) => switch (widget.title) {
                  "앱 튜토리얼 다시보기" => TutorialListTile(context, ref, items[index]),
                  "공지사항" => NoticeListTile(
                    context,
                    ref,
                    items[index].title,
                    items[index].content,
                  ),
                  _ => TutorialListTile(context, ref, "not yet implemented"),
                },
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
}
