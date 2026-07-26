import 'package:finbrain/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'text_theme_viewmodel.g.dart';

// 텍스트 테마 뷰모델
@riverpod
class TextThemeViewmodel extends _$TextThemeViewmodel{
  @override
  TextTheme build() => normalTextTheme;

  void changeTxtTheme(bool isBigTxtMode){
    if(isBigTxtMode){
      state = normalTextTheme;
    } else {
      state = bigTextTheme;
    }
  }
}