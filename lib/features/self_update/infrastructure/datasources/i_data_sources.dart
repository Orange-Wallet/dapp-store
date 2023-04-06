import 'package:dappstore/features/self_update/infrastructure/models/self_update_data_model.dart';

abstract class ISelfUpdateDataSource {
  Future<SelfUpdateDataModel?> getLatestBuild();
}
