import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/entities/wallet_connect_store_model.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/store/i_wallet_connect_store.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IWalletConnectStore)
class WalletConnectStore implements IWalletConnectStore {
  final IErrorLogger errorLogger;

  static const savedWalletConnectStoreBox = "SavedWalletConnectStoreBox";

  WalletConnectStore({required this.errorLogger});

  @override
  Future<WalletConnectStoreModel?> addSignature(
      {required String topicID, required String signature}) async {
    try {
      Box box;
      if (Hive.isBoxOpen(savedWalletConnectStoreBox)) {
        box = Hive.box(savedWalletConnectStoreBox);
      } else {
        box = await Hive.openBox(savedWalletConnectStoreBox);
      }
      final WalletConnectStoreModel wcStore = WalletConnectStoreModel(
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
      if (Hive.isBoxOpen(savedWalletConnectStoreBox)) {
        box = Hive.box(savedWalletConnectStoreBox);
      } else {
        box = await Hive.openBox(savedWalletConnectStoreBox);
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
  Future<Map<dynamic, WalletConnectStoreModel>?> getSignatureMap() async {
    try {
      final Box<WalletConnectStoreModel> box;
      if (Hive.isBoxOpen(savedWalletConnectStoreBox)) {
        box = Hive.box(savedWalletConnectStoreBox);
      } else {
        box = await Hive.openBox(savedWalletConnectStoreBox);
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
    Map<dynamic, WalletConnectStoreModel>? map = await getSignatureMap();
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
      if (Hive.isBoxOpen(savedWalletConnectStoreBox)) {
        box = Hive.box(savedWalletConnectStoreBox);
      } else {
        box = await Hive.openBox(savedWalletConnectStoreBox);
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
