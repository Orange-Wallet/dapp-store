import 'package:dappstore/core/localisation/store/entities/localisation_storage.dart';
import 'package:dappstore/core/localisation/store/i_localisation_store.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ILocalisationStore)
class LocalisationStore implements ILocalisationStore {
  static const localisationStorageBox = "LocalisationStorageBox";
  static const defaultLocale = 'en';
  @override
  setLocale(String locale) async {
    Box<LocalisationStorage> box =
        await Hive.openBox<LocalisationStorage>(localisationStorageBox);
    final LocalisationStorage localeStorage =
        box.get(0) ?? LocalisationStorage();
    localeStorage.locale = locale;
    await box.put(0, localeStorage);
  }

  @override
  setShouldFollowSystem(bool shouldFollowSystem) async {
    Box<LocalisationStorage> box =
        await Hive.openBox<LocalisationStorage>(localisationStorageBox);
    final LocalisationStorage localeStorage =
        box.get(0) ?? LocalisationStorage();
    localeStorage.shouldFollowSystem = shouldFollowSystem;
    await box.put(0, localeStorage);
  }

  @override
  Future<String> locale() async {
    Box<LocalisationStorage> box =
        await Hive.openBox<LocalisationStorage>(localisationStorageBox);
    final LocalisationStorage? localeStorage = box.get(0);
    return localeStorage?.locale ?? defaultLocale;
  }

  @override
  Future<bool> isShouldFollowSystem() async {
    Box<LocalisationStorage> box =
        await Hive.openBox<LocalisationStorage>(localisationStorageBox);
    final LocalisationStorage? localeStorage = box.get(0);

    return localeStorage?.shouldFollowSystem ?? false;
  }
}
