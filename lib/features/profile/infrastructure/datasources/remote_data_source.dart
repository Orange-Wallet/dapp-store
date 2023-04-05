import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/features/profile/infrastructure/datasources/i_data_sources.dart';
import 'package:dappstore/features/profile/infrastructure/models/profile_model.dart';

class RemoteDataSource implements IDataSource {
  final Network _network;
  RemoteDataSource({required Network network}) : _network = network;

  @override
  Future<ProfileModel?> getProfile({required String address}) async {
    // Response res = await _network.get(
    //     path: "${Config.registryApiBaseUrl}/dapp",
    //     queryParams: {"walletAddress": address});
    // if (res.data[address] == null ||
    //     res.data[address].toString().toLowerCase() == "null") {
    //   return null;
    // } else {
    //   return ProfileModel(name: res.data[address], address: address);
    // }
    return null;
  }

  @override
  Future<bool> postProfile({required ProfileModel profile}) async {
    // try {
    //   await _network.post(
    //       path: "${Config.registryApiBaseUrl}/dapp", data: profile.toJson());
    //   return true;
    // } catch (e, stack) {
    //   log("${e.toString()} + $stack");
    //   return false;
    // }
    return true;
  }
}
