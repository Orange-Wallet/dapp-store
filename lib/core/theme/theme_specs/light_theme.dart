import 'package:flutter/material.dart';

import 'i_theme_spec.dart';

class LightTheme implements IThemeSpec {
  @override
  bool get isDarkTheme => false;

  @override
  Color get appBarBackgroundColor => Colors.white;

  @override
  Color get backgroundColor => Colors.white12;
}
