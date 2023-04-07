import 'dart:developer';

import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/features/analytics/datasource/i_datasource.dart';
import 'package:dappstore/features/analytics/dtos/install_analytics_model.dart';

class RemoteDataSource implements IDataSource {
  final Network _network;
  RemoteDataSource({required Network network}) : _network = network;
  @override
  Future<bool?> intallDappEvent(
      {required InstallAnalyticsDTO installAnalyticsDTO}) async {
    try {
      // Response res = await _network.get(
      //     path: "${Config.registryApiBaseUrl}/dapp",
      //     queryParams: installAnalyticsDTO.toJson());

      // return res.data != null;
      return true;
    } catch (e, stack) {
      // TODO catch exception
      log("${e.toString()} : $stack ");
    }
    return null;
  }
}
