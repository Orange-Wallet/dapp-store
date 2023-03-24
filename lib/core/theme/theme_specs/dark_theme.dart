import 'dart:ui';

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
  Color get backgroundCardColor => const Color.fromRGBO(255, 255, 255, 0.1);

  @override
  Color get cardColor => const Color.fromRGBO(255, 255, 255, 0.07);

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
  TextStyle get whiteBoldTextStyle => TextStyle(
        fontFamily: fontName,
        fontSize: 14,
        color: whiteColor,
        fontWeight: FontWeight.w400,
      );

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
