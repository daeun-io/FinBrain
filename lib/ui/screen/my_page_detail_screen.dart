import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/main_screen.dart';
import 'package:finbrain/ui/screen/product_detail_screen.dart';
import 'package:finbrain/ui/viewModel/text_theme_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/ai_comp_tutorial_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_appbar.dart';
import 'package:finbrain/ui/widget/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPageDetailScreen extends ConsumerWidget {
  final String title;
  const MyPageDetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final items = switch (title) {
      "앱 튜토리얼 다시보기" => ["상세 화면 및 AI 채팅", "ISA", "AI 비교 분석"],
      "공지사항" => [],
      "AI 설정" => [],
      _ => [],
    };

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: CupertinoMagnifier.kDefaultSize,
        child: CustomAppbar(screen: "my_page_detail", title: title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) => switch (title) {
            "앱 튜토리얼 다시보기" => TutorialListTile(context, ref, items[index]),
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
      onTap: (){
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
}
