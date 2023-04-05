import 'package:dappstore/features/self_update/infrastructure/models/self_update_store_model.dart';

abstract class ISelfUpdateStore {
  Future<SelfUpdateStoreModel?> addSelfUpdate(
      {required SelfUpdateStoreModel model});
  Future<bool> removeSelfUpdate(String address);
  Future<SelfUpdateStoreModel?> getSelfUpdate(String address);
  Future<bool> clearBox();
  Future<bool> doesSelfUpdateExist(String address);
}
