import 'package:finbrain/themes/text_style.dart';
import 'package:flutter/material.dart';

// 기본 텍스트 크기
// Default text size
final normalTextTheme = TextTheme(
  headlineLarge: headingMd,
  headlineMedium: headingSm,

  titleLarge: bodySbMd,
  titleMedium: bodySbSm,
  titleSmall: bodySbXs,

  bodyLarge: bodyRgMd,
  bodyMedium: bodyRgSm,
  bodySmall: bodyRgXs,

  labelLarge: bodySbSm,
  labelMedium: bodyRgSm,
  labelSmall: captionSb,
);

// 큰 글씨 모드
// Large text size
final bigTextTheme = TextTheme(
  headlineLarge: headingMd,
  headlineMedium: headingSm,

  titleLarge: bodySbXl,
  titleMedium: bodySbLg,
  titleSmall: bodySbMd,

  bodyLarge: bodyRgXl,
  bodyMedium: bodyRgLg,
  bodySmall: bodyRgMd,

  labelLarge: bodySbSm,
  labelMedium: bodyRgSm,
  labelSmall: captionSb,
);
