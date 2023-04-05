import 'package:dappstore/features/self_update/infrastructure/models/self_update_model.dart';

abstract class IDataSource {
  Future<SelfUpdateModel?> getSelfUpdate({
    required String address,
  });
  Future<bool> postSelfUpdate({
    required SelfUpdateModel selfUpdateModel,
  });
}
