import 'package:finbrain/ui/viewmodel/text_theme_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// AI 도우미 스크린 유저 요청(프롬프트)
// AI request(prompt) in assist screen
class AiRequest extends ConsumerWidget {
  const AiRequest({super.key, required this.text});
  
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 0,
        maxWidth: MediaQuery.of(context).size.width * 0.8
      ),
      child: Card(
        color: colorScheme.secondary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(20.0)),
        ),
        elevation: 0.0,
        shadowColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
