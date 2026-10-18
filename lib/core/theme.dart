import 'package:flutter/material.dart';

/// Palette for the light / dark variants of the site.
class LzPalette {
  const LzPalette({
    required this.sky,
    required this.skyDeep,
    required this.paper,
    required this.ink,
    required this.inkSoft,
    required this.inkFaint,
    required this.line,
    required this.buttonBg,
    required this.buttonFg,
    required this.darkStage,
    required this.onDark,
    required this.chromeFg,
  });

  final Color sky;
  final Color skyDeep;
  final Color paper;
  final Color ink;
  final Color inkSoft;
  final Color inkFaint;
  final Color line;
  final Color buttonBg;
  final Color buttonFg;
  final Color darkStage;
  final Color onDark;

  /// Foreground colour used by the fixed header / footer chrome.
  final Color chromeFg;

  static const light = LzPalette(
    sky: Color(0xFFC8DFEB),
    skyDeep: Color(0xFFBBD6E7),
    paper: Color(0xFFF0F0EE),
    ink: Color(0xFF111111),
    inkSoft: Color(0x9E111111),
    inkFaint: Color(0x5C111111),
    line: Color(0x14000000),
    buttonBg: Color(0xFF111111),
    buttonFg: Color(0xFFFFFFFF),
    darkStage: Color(0xFF08090B),
    onDark: Color(0xFFFFFFFF),
    chromeFg: Color(0xFF111111),
  );

  static const dark = LzPalette(
    sky: Color(0xFF10151B),
    skyDeep: Color(0xFF0C1116),
    paper: Color(0xFF161B21),
    ink: Color(0xFFF2F5F7),
    inkSoft: Color(0xA8F2F5F7),
    inkFaint: Color(0x66F2F5F7),
    line: Color(0x1FFFFFFF),
    buttonBg: Color(0xFFF2F5F7),
    buttonFg: Color(0xFF10151B),
    darkStage: Color(0xFF040507),
    onDark: Color(0xFFF7FAFC),
    chromeFg: Color(0xFFF2F5F7),
  );
}

/// Site wide constants borrowed from the reference layout.
class Lz {
  static const accent = Color(0xFFC0FE04);

  static const sansFamily = 'TikTok Sans';
  static const monoFamily = 'Geist Mono';
  static const labelFamily = 'Departure Mono';

  /// Fonts used when a glyph is missing from the bundled Latin faces.
  static const cjkFallback = <String>[
    'Noto Sans SC',
    'PingFang SC',
    'Hiragino Sans GB',
    'Heiti SC',
    'Microsoft YaHei',
    'Noto Sans CJK SC',
    'Source Han Sans SC',
    'sans-serif',
  ];

  static TextStyle sans({
    required double size,
    FontWeight weight = FontWeight.w500,
    double? height,
    double? letterSpacing,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: sansFamily,
      fontFamilyFallback: cjkFallback,
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: letterSpacing,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle mono({
    required double size,
    double? height,
    double? letterSpacing,
    FontWeight weight = FontWeight.w400,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: monoFamily,
      fontFamilyFallback: cjkFallback,
      fontSize: size,
      fontWeight: weight,
      height: height ?? 1.55,
      letterSpacing: letterSpacing,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle label({
    required double size,
    double? height,
    double? letterSpacing,
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) {
    return TextStyle(
      fontFamily: labelFamily,
      fontFamilyFallback: cjkFallback,
      fontSize: size,
      fontWeight: weight,
      height: height ?? 1.5,
      letterSpacing: letterSpacing ?? size * 0.08,
      color: color,
      decoration: TextDecoration.none,
    );
  }
}

/// Responsive breakpoints, mirroring the reference site.
enum FormFactor { mobile, tablet, desktop }

FormFactor formFactorFor(double width) {
  if (width < 768) return FormFactor.mobile;
  if (width < 1024) return FormFactor.tablet;
  return FormFactor.desktop;
}

extension FormFactorX on FormFactor {
  bool get isMobile => this == FormFactor.mobile;
  bool get isDesktop => this == FormFactor.desktop;

  /// Horizontal page gutter.
  double get gutter => switch (this) {
    FormFactor.mobile => 16,
    FormFactor.tablet => 24,
    FormFactor.desktop => 56,
  };
}

class LzTheme {
  static ThemeData build({
    required LzPalette palette,
    required Brightness brightness,
  }) {
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF3A7BD5),
      brightness: brightness,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: palette.sky,
      fontFamily: Lz.sansFamily,
      fontFamilyFallback: Lz.cjkFallback,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      textTheme: TextTheme(
        bodyMedium: Lz.sans(size: 15, color: palette.ink),
      ),
    );
  }
}
