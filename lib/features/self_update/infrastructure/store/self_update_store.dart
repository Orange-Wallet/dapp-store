import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/features/self_update/infrastructure/models/self_update_store_model.dart';
import 'package:dappstore/features/self_update/infrastructure/store/i_self_update_store.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISelfUpdateStore)
class SelfUpdateStore implements ISelfUpdateStore {
  final IErrorLogger errorLogger;

  static const savedSelfUpdateStoreBox = "SavedSelfUpdateStoreBox";

  SelfUpdateStore({required this.errorLogger});

  @override
  Future<SelfUpdateStoreModel?> addSelfUpdate(
      {required SelfUpdateStoreModel model}) async {
    try {
      Box box;
      if (Hive.isBoxOpen(savedSelfUpdateStoreBox)) {
        box = Hive.box(savedSelfUpdateStoreBox);
      } else {
        box = await Hive.openBox(savedSelfUpdateStoreBox);
      }

      await box.put(model.address, model);
      await box.close();
      return model;
    } catch (e) {
      errorLogger.logError(e);
      return null;
    }
  }

  @override
  Future<bool> removeSelfUpdate(String address) async {
    try {
      Box box;
      if (Hive.isBoxOpen(savedSelfUpdateStoreBox)) {
        box = Hive.box(savedSelfUpdateStoreBox);
      } else {
        box = await Hive.openBox(savedSelfUpdateStoreBox);
      }
      await box.delete(address);
      await box.close();
      return true;
    } catch (e) {
      errorLogger.logError(e);
      return false;
    }
  }

  @override
  Future<SelfUpdateStoreModel?> getSelfUpdate(String address) async {
    try {
      final Box<SelfUpdateStoreModel> box;
      if (Hive.isBoxOpen(savedSelfUpdateStoreBox)) {
        box = Hive.box(savedSelfUpdateStoreBox);
      } else {
        box = await Hive.openBox(savedSelfUpdateStoreBox);
      }
      await box.close();
      return box.toMap()[address];
    } catch (e) {
      errorLogger.logError(e);
      return null;
    }
  }

  @override
  Future<bool> doesSelfUpdateExist(String address) async {
    SelfUpdateStoreModel? SelfUpdate = await getSelfUpdate(address);
    if (SelfUpdate == null) {
      return false;
    } else {
      return false;
    }
  }

  @override
  Future<bool> clearBox() async {
    try {
      Box box;
      if (Hive.isBoxOpen(savedSelfUpdateStoreBox)) {
        box = Hive.box(savedSelfUpdateStoreBox);
      } else {
        box = await Hive.openBox(savedSelfUpdateStoreBox);
      }
      await box.deleteFromDisk();
      await box.close();
      return true;
    } catch (e) {
      errorLogger.logError(e);
      return false;
    }
  }
}
