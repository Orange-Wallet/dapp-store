import 'package:flutter/material.dart';

abstract class IThemeSpec {
  String get fontName;

  bool get isDarkTheme;

  double get imageBorderRadius => 20;

  double get themeHeight;
  double get themeWidth;

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
  Color get ratingGrey;
  Color get unratedGrey;
  Color get errorRed;
  Color get blue;
  Color get greyBlue;
  Color get black;

  TextStyle get secondaryTextStyle1;
  TextStyle get headingTextStyle;
  TextStyle get buttonTextStyle;
  TextStyle get bodyTextStyle;
  TextStyle get titleTextStyle;
  TextStyle get secondaryTitleTextStyle;
  TextStyle get whiteBoldTextStyle;
  TextStyle get titleTextExtraBold;
  TextStyle get normalTextStyle;
  TextStyle get normalTextStyle2;
  TextStyle get secondaryTextStyle2;
  TextStyle get smallButtonTextStyle;
  TextStyle get whiteButtonTextStyle;
  TextStyle get secondaryWhiteTextStyle3;
  TextStyle get secondaryGreenTextStyle4;
  TextStyle get greyHeading;

  double get cardRadius;
  RoundedRectangleBorder get cardShape;

  double relativeWidth(double w);
  double relativeHeight(double h);
  double relativeTextSize(double s);
}
