import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/features/self_update/infrastructure/datasources/i_data_sources.dart';
import 'package:dappstore/features/self_update/infrastructure/models/self_update_model.dart';

class RemoteDataSource implements IDataSource {
  final Network _network;
  RemoteDataSource({required Network network}) : _network = network;

  @override
  Future<SelfUpdateModel?> getSelfUpdate({required String address}) async {
    // Response res = await _network.get(
    //     path: "${Config.registryApiBaseUrl}/dapp",
    //     queryParams: {"walletAddress": address});
    // if (res.data[address] == null ||
    //     res.data[address].toString().toLowerCase() == "null") {
    //   return null;
    // } else {
    //   return SelfUpdateModel(name: res.data[address], address: address);
    // }
    return null;
  }

  @override
  Future<bool> postSelfUpdate(
      {required SelfUpdateModel selfUpdateModel}) async {
    // try {
    //   await _network.post(
    //       path: "${Config.registryApiBaseUrl}/dapp", data: SelfUpdate.toJson());
    //   return true;
    // } catch (e, stack) {
    //   log("${e.toString()} + $stack");
    //   return false;
    // }
    return true;
  }
}
