import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final TextTheme textTheme = GoogleFonts.poppinsTextTheme();

  static ThemeData lightTheme = FlexThemeData.light(
    scheme: FlexScheme.blue,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 7,
    textTheme: textTheme,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      useM2StyleDividerInM3: true,
      defaultRadius: 12.0,
      thickBorderWidth: 2.0,
      thinBorderWidth: 1.0,
      textButtonRadius: 8.0,
      elevatedButtonRadius: 8.0,
      outlinedButtonRadius: 8.0,
      inputDecoratorRadius: 8.0,
      cardRadius: 12.0,
      dialogRadius: 16.0,
    ),
    keyColors: const FlexKeyColors(
      useSecondary: true,
      useTertiary: true,
      keepPrimary: true,
    ),
    tones: FlexTones.jolly(Brightness.light),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
  );

  static ThemeData darkTheme = FlexThemeData.dark(
    scheme: FlexScheme.blue,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 13,
    textTheme: textTheme,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      useM2StyleDividerInM3: true,
      defaultRadius: 12.0,
      thickBorderWidth: 2.0,
      thinBorderWidth: 1.0,
      textButtonRadius: 8.0,
      elevatedButtonRadius: 8.0,
      outlinedButtonRadius: 8.0,
      inputDecoratorRadius: 8.0,
      cardRadius: 12.0,
      dialogRadius: 16.0,
    ),
    keyColors: const FlexKeyColors(
      useSecondary: true,
      useTertiary: true,
      keepPrimary: true,
    ),
    tones: FlexTones.jolly(Brightness.dark),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
  );
}
