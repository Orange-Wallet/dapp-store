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
  Color get appGreen;
  Color get backgroundCardColor;
  Color get cardColor;

  TextStyle get secondaryTextStyle1;
  TextStyle get headingTextStyle;
  TextStyle get buttonTextStyle;
  TextStyle get bodyTextStyle;
  TextStyle get titleTextStyle;
  TextStyle get whiteBoldTextStyle;
  TextStyle get normalTextStyle;
  TextStyle get secondaryTextStyle2;
  TextStyle get smallButtonTextStyle;

  double get cardRadius;
  RoundedRectangleBorder get cardShape;
}
