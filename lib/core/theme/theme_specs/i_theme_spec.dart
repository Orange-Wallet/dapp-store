import 'package:flutter/material.dart';

abstract class IThemeSpec {
  bool get isDarkTheme;
  Color get backgroundColor;
  Color get appBarBackgroundColor;
}
