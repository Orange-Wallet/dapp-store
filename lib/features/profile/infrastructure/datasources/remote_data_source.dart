import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';
import 'package:dappstore/features/profile/infrastructure/datasources/i_data_sources.dart';
import 'package:dappstore/features/profile/infrastructure/models/profile_model.dart';

class RemoteDataSource implements IDataSource {
  final Network _network;
  RemoteDataSource({required Network network}) : _network = network;

  @override
  Future<ProfileModel> getDappList({GetDappQueryDto? queryParams}) {
    // TODO: implement getDappList
    throw UnimplementedError();
  }
}
