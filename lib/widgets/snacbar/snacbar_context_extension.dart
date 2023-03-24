import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:flutter/material.dart';

extension LocaleExtension on BuildContext {
  showErrorBar(String message, IThemeSpec theme) {
    final snackBar = SnackBar(
      backgroundColor: theme.errorRed,
      content: Text(message),
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }

  showMsgBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
