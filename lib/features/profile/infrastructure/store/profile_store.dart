import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/features/profile/infrastructure/models/profile_store_model.dart';
import 'package:dappstore/features/profile/infrastructure/store/i_profile_store.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IProfileStore)
class ProfileStore implements IProfileStore {
  final IErrorLogger errorLogger;

  static const savedProfileStoreBox = "SavedProfileStoreBox";

  ProfileStore({required this.errorLogger});

  @override
  Future<ProfileStoreModel?> addSignature(
      {required String topicID, required String signature}) async {
    try {
      Box box;
      if (Hive.isBoxOpen(savedProfileStoreBox)) {
        box = Hive.box(savedProfileStoreBox);
      } else {
        box = await Hive.openBox(savedProfileStoreBox);
      }
      final ProfileStoreModel wcStore = ProfileStoreModel(
        topidID: topicID,
        signature: signature,
      );
      await box.put(topicID, wcStore);
      await box.close();
      return wcStore;
    } catch (e) {
      errorLogger.logError(e);
      return null;
    }
  }

  @override
  Future<bool> removeSignature(String topicID) async {
    try {
      Box box;
      if (Hive.isBoxOpen(savedProfileStoreBox)) {
        box = Hive.box(savedProfileStoreBox);
      } else {
        box = await Hive.openBox(savedProfileStoreBox);
      }
      await box.delete(topicID);
      await box.close();
      return true;
    } catch (e) {
      errorLogger.logError(e);
      return false;
    }
  }

  @override
  Future<Map<dynamic, ProfileStoreModel>?> getSignatureMap() async {
    try {
      final Box<ProfileStoreModel> box;
      if (Hive.isBoxOpen(savedProfileStoreBox)) {
        box = Hive.box(savedProfileStoreBox);
      } else {
        box = await Hive.openBox(savedProfileStoreBox);
      }
      await box.close();
      return box.toMap();
    } catch (e) {
      errorLogger.logError(e);
      return null;
    }
  }

  @override
  Future<bool> doesSignExist(String topicID) async {
    Map<dynamic, ProfileStoreModel>? map = await getSignatureMap();
    if (map == null) {
      return false;
    } else if (map[topicID] == null) {
      return false;
    } else if (map[topicID] != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> clearBox() async {
    try {
      Box box;
      if (Hive.isBoxOpen(savedProfileStoreBox)) {
        box = Hive.box(savedProfileStoreBox);
      } else {
        box = await Hive.openBox(savedProfileStoreBox);
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
