import 'package:dappstore/config/config.dart';
import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/features/self_update/infrastructure/datasources/i_data_sources.dart';
import 'package:dappstore/features/self_update/infrastructure/models/self_update_data_model.dart';
import 'package:dio/dio.dart';

class RemoteDataSource implements ISelfUpdateDataSource {
  final Network _network;
  RemoteDataSource({required Network network}) : _network = network;

  @override
  Future<SelfUpdateDataModel?> getLatestBuild() async {
    Response res = await _network.get(
      path: "${Config.registryApiBaseUrl}/dappstore",
    );

    return SelfUpdateDataModel.fromJson(res.data);
  }
}
