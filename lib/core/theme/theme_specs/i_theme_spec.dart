import 'package:flutter/material.dart';

abstract class IThemeSpec {
  String get fontName;

  bool get isDarkTheme;

  double get imageBorderRadius;
  double get cardRadius;
  double get buttonRadius;
  double get wcIconSize;

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
  Color get greyArrowColor;
  Color get gradientBlue;
  Color get gradientBlue2;
  Color get buttonBlue;
  Color get buttonRed;
  Color get wcBlue;
  Color get sheetBackgroundColor;

  TextStyle get secondaryTextStyle1;
  TextStyle get headingTextStyle;
  TextStyle get buttonTextStyle;
  TextStyle get bodyTextStyle;
  TextStyle get titleTextStyle;
  TextStyle get biggerTitleTextStyle;
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
  TextStyle get redButtonText;

  RoundedRectangleBorder get cardShape;
  RoundedRectangleBorder get sheetCardShape;

  double relativeWidth(double w);
  double relativeHeight(double h);
  double relativeTextSize(double s);
}
