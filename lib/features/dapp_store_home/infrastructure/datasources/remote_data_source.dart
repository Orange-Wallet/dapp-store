import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_info_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_list_dto.dart';

class RemoteDataSource {
  final Network _network;
  RemoteDataSource({required Network network}) : _network = network;

  Future<DappListDto> getDappList() async {
    _network.get(path: "");
    //dio api call
    return DappListDto();
  }

  Future<DappInfoDto> getDappInfo(String ID) async {
    //dio api call
    return DappInfoDto();
  }

  Future<List<DappInfoDto>> searchDapps(String searchString) async {
    //dio api call
    return [DappInfoDto()];
  }
}
