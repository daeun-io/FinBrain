import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    // background
    primary: white,
    secondary: lightGray,
    tertiary: lightGrayishBlue,
    surface: transparent,
    // dialog background
    surfaceContainer: white,
    // text
    onPrimary: navy,
    onSecondary: black,
    onTertiary: grayishBlue,
    onSurface: white,
    onSecondaryContainer: white,
    // border
    outline: paleBlue,
    outlineVariant: skyBlue,
    // liked
    onPrimaryFixed: neonPink,
    onPrimaryFixedVariant: white,
    // pinned
    onSecondaryFixed: yellow,
    onSecondaryFixedVariant: grayishBlue,
    // radio/check/circulator/indicator
    onTertiaryFixed: lightSkyBlue,
    // filterchip/isa-tab-indicator
    surfaceContainerHigh: skyBlue,
    // ai button
    surfaceDim: blueHeist85,
    // other button
    surfaceContainerHighest: blueHeist,
    // gradient
    surfaceContainerLowest: paleBlue55,
    surfaceContainerLow: pastelSkyBlue55,
    // indicator/snackbar background
    scrim: gray,
    // slider
    surfaceBright: paleBlue,
  ),
);

final ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
    // background
    primary: offBlack,
    secondary: darkGray,
    tertiary: darkGrayishBlue,
    surface: transparent,
    // dialog background
    surfaceContainer: darkGray,
    // text
    onPrimary: paleBlue,
    onSecondary: white,
    onTertiary: grayishBlue,
    onSurface: white,
    onSecondaryContainer: black,
    // border
    outline: paleBlue,
    outlineVariant: skyBlue,
    // liked
    onPrimaryFixed: neonPink,
    onPrimaryFixedVariant: paleBlue,
    // pinned
    onSecondaryFixed: yellow,
    onSecondaryFixedVariant: grayishBlue,
    // radio/check/circulator/indicator
    onTertiaryFixed: lightSkyBlue,
    // filterchip/isa-tab-indicator
    surfaceContainerHigh: blueHeist,
    // ai button
    surfaceDim: blueHeist85,
    // other button
    surfaceContainerHighest: lightGrayishBlue,
    // gradient
    surfaceContainerLowest: paleBlue55,
    surfaceContainerLow: pastelSkyBlue55,
    // indicator/snackbar background
    scrim: ashGray,
    // slider
    surfaceBright: darkGrayishBlue
  ),
);