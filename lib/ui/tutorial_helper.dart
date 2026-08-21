import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

// 튜토리얼 보이기
void showTutorial(
  BuildContext context,
  List<TargetFocus> targets, [
    Function()? onFinishOrSkip,
  ]
) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  TutorialCoachMark(
    targets: targets,
    textSkip: "건너뛰기",
    textStyleSkip: textTheme.bodySmall!.copyWith(color: colorScheme.onSurface),
    pulseEnable: false,
    onFinish: () async {
      if(onFinishOrSkip != null){
        await onFinishOrSkip();
      }
    },
    onSkip: () {
      if(onFinishOrSkip != null){
        onFinishOrSkip();
      }
      return true;
    },
  ).show(context: context);
}

// 튜토리얼 추가하는 함수
// Add tutorial target
void initTarget(
  BuildContext context,
  List<TargetFocus> targets,
  GlobalKey key,
  ContentAlign alignment,
  ShapeLightFocus shape,
  String content, [
  String? content2,
]) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  targets.add(
    TargetFocus(
      identify: key,
      keyTarget: key,
      shape: shape,
      contents: [
        TargetContent(
          align: alignment,
          child: Column(children: [
              TutorialBox(context, colorScheme, textTheme, content),
              if(content2 != null) ...[
                const SizedBox(height: 16,),
                TutorialBox(context, colorScheme, textTheme, content2)
              ]
            ],
          ),
        ),
      ],
    ),
  );
}

Container TutorialBox(
  BuildContext context,
  ColorScheme colorScheme,
  TextTheme textTheme,
  String content,
) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: colorScheme.secondary,
      borderRadius: BorderRadius.circular(20),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Text(
      content,
      style: textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary),
    ),
  );
}
