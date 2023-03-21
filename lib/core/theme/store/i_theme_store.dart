import 'package:dappstore/core/theme/store/entities/theme_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IThemeStore {
  setCurrentTheme(bool isDarkEnabled);

  Future<bool> isDarkThemeEnabled();
}
