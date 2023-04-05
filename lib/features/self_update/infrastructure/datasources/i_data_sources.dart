import 'package:dappstore/features/self_update/infrastructure/models/self_update_store_model.dart';

abstract class IDataSource {
  Future<SelfUpdateDataModel?> getLatestBuild();
}
