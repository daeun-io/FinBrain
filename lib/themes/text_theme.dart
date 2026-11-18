import 'package:finbrain/themes/text_style.dart';
import 'package:flutter/material.dart';

// 기본 텍스트 크기
// Default text size
final normalTextTheme = TextTheme(
  headlineLarge: headingSbMd,
  headlineMedium: headingSm,
  headlineSmall: bodySbLg,

  displayLarge: headingRgMd,

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
  headlineLarge: headingSbMd,
  headlineMedium: headingSm,
  headlineSmall: bodySbXl,

  displayLarge: headingRgLg,

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
