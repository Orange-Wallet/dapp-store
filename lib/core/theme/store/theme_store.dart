import 'package:dappstore/core/theme/store/entities/theme_storage.dart';
import 'package:dappstore/core/theme/store/i_theme_store.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IThemeStore)
class ThemeStore implements IThemeStore {
  static const themeStoageBoxName = "ThemeStorageBox";

  @override
  setCurrentTheme(bool isDarkEnabled) async {
    Box<ThemeStorage> box =
        await Hive.openBox<ThemeStorage>(themeStoageBoxName);
    await box.putAt(0, ThemeStorage(isDarkEnabled: isDarkEnabled));
  }

  @override
  Future<bool> isDarkThemeEnabled() async {
    Box<ThemeStorage> box =
        await Hive.openBox<ThemeStorage>(themeStoageBoxName);
    final ThemeStorage? themeStorage = box.getAt(0);
    return themeStorage?.isDarkEnabled ?? false;
  }
}
