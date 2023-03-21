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
    await box.put(0, ThemeStorage(isDarkEnabled: isDarkEnabled));
  }

  @override
  setShouldFollowSystem(bool shouldFollowSystem) async {
    Box<ThemeStorage> box =
        await Hive.openBox<ThemeStorage>(themeStoageBoxName);
    await box.put(0, ThemeStorage(shouldFollowSystem: shouldFollowSystem));
  }

  @override
  Future<bool> isDarkThemeEnabled() async {
    Box<ThemeStorage> box =
        await Hive.openBox<ThemeStorage>(themeStoageBoxName);
    final ThemeStorage? themeStorage = box.get(0);
    return themeStorage?.isDarkEnabled ?? false;
  }

  @override
  Future<bool> isShouldFollowSystem() async {
    Box<ThemeStorage> box =
        await Hive.openBox<ThemeStorage>(themeStoageBoxName);
    final ThemeStorage? themeStorage = box.get(0);
    return themeStorage?.shouldFollowSystem ?? false;
  }
}
