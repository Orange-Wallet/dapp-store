import 'package:dappstore/features/profile/infrastructure/models/profile_store_model.dart';

abstract class IProfileStore {
  Future<ProfileStoreModel?> addSignature(
      {required String topicID, required String signature});
  Future<bool> removeSignature(String topicID);
  Future<Map<dynamic, ProfileStoreModel>?> getSignatureMap();
  Future<bool> clearBox();
  Future<bool> doesSignExist(String topicID);
}
