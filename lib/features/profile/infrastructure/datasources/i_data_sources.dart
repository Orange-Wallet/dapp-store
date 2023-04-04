import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';
import 'package:dappstore/features/profile/infrastructure/models/profile_model.dart';

abstract class IDataSource {
  Future<ProfileModel> getDappList({
    GetDappQueryDto? queryParams,
  });
}
