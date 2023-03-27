import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:flutter/material.dart';

class DarkTheme implements IThemeSpec {
  @override
  bool get isDarkTheme => true;

  @override
  Color get appBarBackgroundColor => Colors.black;

  @override
  Color get backgroundColor => const Color.fromRGBO(0, 0, 0, 0.2363);

  @override
  Color get secondaryTextColor => const Color.fromARGB(255, 114, 114, 114);

  @override
  Color get whiteColor => const Color.fromARGB(255, 255, 255, 255);

  @override
  Color get secondaryBackgroundColor => const Color.fromARGB(255, 51, 51, 51);

  @override
  Color get thirdBackgroundColor => const Color.fromARGB(255, 37, 37, 37);

  @override
  Color get bodyTextColor => const Color.fromARGB(255, 139, 137, 147);

  @override
  Color get arrowButtonBackgroundColor =>
      const Color.fromRGBO(192, 195, 201, 1);

  @override
  Color get appGreen => const Color.fromRGBO(77, 204, 143, 1);

  @override
  Color get backgroundCardColor => const Color.fromARGB(255, 26, 26, 26);

  @override
  Color get cardColor => const Color.fromARGB(255, 42, 42, 42);

  @override
  Color get ratingGrey => const Color.fromARGB(255, 178, 178, 178);

  @override
  Color get unratedGrey => const Color.fromARGB(255, 76, 76, 76);
  @override
  Color get errorRed => const Color.fromARGB(255, 194, 60, 60);

  @override
  Color get blue => const Color.fromARGB(255, 60, 152, 194);

  @override
  Color get greyBlue => const Color.fromARGB(255, 46, 93, 115);

  @override
  Color get black => const Color.fromARGB(255, 0, 0, 0);

  @override
  TextStyle get headingTextStyle => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: 24,
        color: whiteColor,
        fontWeight: FontWeight.w600,
      );

  @override
  TextStyle get secondaryTextStyle1 => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: 10,
        color: secondaryTextColor,
      );

  @override
  TextStyle get secondaryTextStyle2 => TextStyle(
      // h5 -> headline
      fontFamily: fontName,
      fontSize: 10,
      color: whiteColor,
      fontWeight: FontWeight.w500);

  @override
  TextStyle get secondaryWhiteTextStyle3 => TextStyle(
      // h5 -> headline
      fontFamily: fontName,
      fontSize: 10,
      color: whiteColor,
      fontWeight: FontWeight.w400);
  @override
  TextStyle get secondaryGreenTextStyle4 => TextStyle(
      // h5 -> headline
      fontFamily: fontName,
      fontSize: 10,
      color: appGreen,
      fontWeight: FontWeight.w400);

  @override
  TextStyle get titleTextStyle => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: whiteColor,
      );

  @override
  TextStyle get bodyTextStyle => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: bodyTextColor,
      );

  @override
  TextStyle get buttonTextStyle => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: 14,
        color: whiteColor,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get smallButtonTextStyle => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: 12,
        color: whiteColor,
        fontWeight: FontWeight.w700,
      );
  @override
  TextStyle get normalTextStyle => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: 14,
        color: whiteColor,
        fontWeight: FontWeight.w500,
      );
  @override
  TextStyle get normalTextStyle2 => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: 14,
        color: whiteColor,
        fontWeight: FontWeight.w600,
      );

  @override
  TextStyle get whiteBoldTextStyle => TextStyle(
        fontFamily: fontName,
        fontSize: 14,
        color: whiteColor,
        fontWeight: FontWeight.w400,
      );

  @override
  TextStyle get whiteButtonTextStyle => TextStyle(
        fontFamily: fontName,
        fontSize: 14,
        color: black,
        fontWeight: FontWeight.w600,
      );

  @override
  double get imageBorderRadius => 20;

  @override
  String get fontName => 'GeneralSans';

  @override
  double get cardRadius => 16;

  @override
  RoundedRectangleBorder get cardShape => const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      );
}
