import 'package:finbrain/themes/text_style.dart';
import 'package:flutter/material.dart';

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
