import 'package:flutter/material.dart';

///  theme mode
enum AppThemeMode {
  Light,
  Dark,
}

///字体模式
enum AppFontMode {
  ///默认字体
  Roboto,

  ///三方字体
  MaShanZheng,
}

///颜色模式，特定view背景颜色
enum AppThemeColorMode { Indigo, Orange, Pink, Teal, Blue, Cyan, Purple }

class GradientColor {
  final AppThemeColorMode mode;
  final Color start;
  final Color end;

  GradientColor(this.mode, this.start, this.end);
}

class AppTheme {
  static List<GradientColor> gradientColors = [
    //Colors.indigo
    GradientColor(AppThemeColorMode.Indigo, Color.fromARGB(255, 101, 89, 184),
        Color.fromARGB(255, 112, 113, 228)),
    //Colors.orange
    GradientColor(AppThemeColorMode.Orange, Color.fromARGB(255, 253, 145, 141),
        Color.fromARGB(255, 252, 178, 146)),
    //Colors.pink
    GradientColor(AppThemeColorMode.Pink, Color.fromARGB(255, 242, 79, 136),
        Color.fromARGB(255, 249, 88, 110)),
    //Colors.teal
    GradientColor(AppThemeColorMode.Teal, Color.fromARGB(255, 56, 155, 148),
        Color.fromARGB(255, 80, 201, 145)),
    //Colors.blue
    GradientColor(AppThemeColorMode.Blue, Color.fromARGB(255, 59, 137, 172),
        Color.fromARGB(255, 90, 133, 227)),
    //Colors.cyan
    GradientColor(AppThemeColorMode.Cyan, Color.fromARGB(255, 21, 177, 202),
        Color.fromARGB(255, 25, 209, 201)),
  ];

  AppTheme._();

  static final AppTheme appTheme = AppTheme._();

  AppThemeMode currentThemeMode;
  AppThemeColorMode currentColorMode;
  AppFontMode currentFontMode;

  String fontFamliy;

  String numFontFamliy = 'Montserrat';

  GradientColor gradientColor;

  ThemeData createTheme(AppThemeMode themeMode,
      AppThemeColorMode themeColorMode, AppFontMode fontMode) {
    currentThemeMode = themeMode;
    currentColorMode = themeColorMode;
    currentFontMode = fontMode;
    fontFamliy = fontFamily(currentFontMode);
    gradientColor = getGradientColor(currentColorMode);
    if (themeMode == AppThemeMode.Dark) {
      return darkTheme();
    } else {
      return lightTheme();
    }
  }

  bool isDark() {
    return currentThemeMode == AppThemeMode.Dark;
  }

  ThemeData lightTheme() {
    return ThemeData.light().copyWith(
        primaryColor: Color(0xFFF2F7FB),
        primaryColorDark: Color(0xFF6B6B6B),
        primaryColorLight: Colors.blueAccent);
  }

  ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: Color(0xFF17262A),
      primaryColorDark: Color(0xFF6B6B6B),
    );
  }

  String fontFamily(AppFontMode fontMode) {
    switch (fontMode) {
      case AppFontMode.MaShanZheng:
        return 'MaShanZheng';
    }
    return 'Roboto';
  }

  GradientColor getGradientColor(AppThemeColorMode mode) {
    for (var value in gradientColors) {
      if (mode == value.mode) {
        return value;
      }
    }
    return gradientColors.first;
  }

  ///------------字体------------
  /// 黑/白
  TextStyle headline1(
      {FontWeight fontWeight, double fontSize, Color textColor}) {
    return TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: textColor == null
            ? (isDark() ? Colors.white : Colors.black)
            : textColor,
        fontFamily: fontFamliy);
  }

  /// 黑/灰色
  TextStyle headline2(
      {FontWeight fontWeight, double fontSize, Color textColor}) {
    return TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: textColor == null
            ? (isDark() ? Colors.grey : Colors.black)
            : textColor,
        fontFamily: fontFamliy);
  }

  /// Edit hint text
  TextStyle hint({FontWeight fontWeight, double fontSize}) {
    return TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: isDark() ? Colors.white : Colors.black.withOpacity(0.5),
        fontFamily: fontFamliy);
  }

  /// theme color text
  TextStyle themeText({FontWeight fontWeight, double fontSize}) {
    return TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: grandientColorStart(),
        fontFamily: fontFamliy);
  }

  ///数字
  TextStyle numHeadline1({FontWeight fontWeight, double fontSize}) {
    return TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: isDark() ? Colors.white : Colors.black,
        fontFamily: numFontFamliy);
  }

  ///数字
  TextStyle numHeadline2({FontWeight fontWeight, double fontSize}) {
    return TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: isDark() ? Colors.grey : Colors.black,
        fontFamily: numFontFamliy);
  }

  TextStyle textStyle(
      {Color textColor, FontWeight fontWeight, double fontSize}) {
    return TextStyle(
        fontFamily: fontFamily(currentFontMode),
        fontSize: fontSize ?? 20,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: textColor ?? (isDark() ? Colors.white70 : Colors.black));
  }

  ///-------------背景--------------
  ///容器背景颜色
  Color containerBackgroundColor() {
    return isDark() ? Color(0xFF233355) : Color(0xFFF2F7FB);
  }

  ///所有卡片背景颜色
  Color cardBackgroundColor() {
    return isDark() ? Color(0xFF294261) : Colors.white;
  }

  Color normalColor() {
    return isDark() ? Colors.white : Colors.black;
  }

  ///渐变开始颜色
  Color grandientColorStart() {
    return gradientColor.start;
  }

  ///渐变结束颜色
  Color grandientColorEnd() {
    return gradientColor.end;
  }

  ///背景统一渐变色
  LinearGradient containerGradient({Alignment begin, Alignment end}) {
    return LinearGradient(
        colors: [grandientColorStart(), grandientColorEnd()],
        begin: begin,
        end: end);
  }

  ///通一阴影
  List<BoxShadow> containerBoxShadow() {
    return [
      BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: Offset(5, 5),
          blurRadius: 16)
    ];
  }

  ///带颜色阴影
  List<BoxShadow> coloredBoxShadow() {
    return [
      BoxShadow(
          color: grandientColorStart().withOpacity(0.1),
          offset: Offset(5, 5),
          blurRadius: 16)
    ];
  }

  Color selectColor() {
    return isDark() ? Colors.white : Colors.black;
  }

  static const Color iconColor = Colors.grey;
}
