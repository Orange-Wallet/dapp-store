import 'package:flutter/material.dart';

abstract class IThemeSpec {
  String get fontName;

  bool get isDarkTheme;

  double get imageBorderRadius => 20;

  Color get backgroundColor;
  Color get appBarBackgroundColor;
  Color get secondaryTextColor;
  Color get bodyTextColor;
  Color get secondaryBackgroundColor;
  Color get thirdBackgroundColor;
  Color get whiteColor;
  Color get arrowButtonBackgroundColor;

  TextStyle get secondaryTextStyle1;
  TextStyle get headingTextStyle;
  TextStyle get buttonTextStyle;
  TextStyle get bodyTextStyle;
  TextStyle get titleTextStyle;
}
