import 'dart:ui';

import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:flutter/material.dart';

class DarkTheme implements IThemeSpec {
  @override
  bool get isDarkTheme => true;

  @override
  Color get appBarBackgroundColor => Colors.black;

  @override
  Color get backgroundColor => Colors.black12;
}
