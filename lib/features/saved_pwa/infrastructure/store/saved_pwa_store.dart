import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/saved_pwa/infrastructure/entities/saved_dapp_model.dart';
import 'package:dappstore/features/saved_pwa/infrastructure/store/i_saved_pwa_store.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISavedPwaStore)
class SavedPwaStore implements ISavedPwaStore {
  final IErrorLogger errorLogger;

  static const savedPwaStoreBox = "SavedPwaStoreBox";

  SavedPwaStore({required this.errorLogger});
  @override
  Future<SavedPwaModel?> addDapp(DappInfo dappInfo) async {
    try {
      Box box = await Hive.openBox(savedPwaStoreBox);
      final SavedPwaModel savedPwa = SavedPwaModel(
        name: dappInfo.name!,
        dappId: dappInfo.dappId!,
        logo: dappInfo.images?.logo,
        banner: dappInfo.images?.banner,
      );
      await box.put(dappInfo.dappId!, savedPwa);
      return savedPwa;
    } catch (e) {
      errorLogger.logError(e);
      return null;
    }
  }

  @override
  Future<bool> removeDapp(String dappId) async {
    try {
      final Box box = await Hive.openBox(savedPwaStoreBox);
      await box.delete(dappId);
      return true;
    } catch (e) {
      errorLogger.logError(e);
      return false;
    }
  }

  @override
  Future<Map<dynamic, SavedPwaModel>?> getSavedDapps() async {
    try {
      final Box<SavedPwaModel> box = await Hive.openBox(savedPwaStoreBox);
      return box.toMap();
    } catch (e) {
      errorLogger.logError(e);
      return null;
    }
  }

  @override
  Future<bool> clearBox() async {
    try {
      final Box box = await Hive.openBox(savedPwaStoreBox);
      await box.deleteFromDisk();
      return true;
    } catch (e) {
      errorLogger.logError(e);
      return false;
    }
  }
}
