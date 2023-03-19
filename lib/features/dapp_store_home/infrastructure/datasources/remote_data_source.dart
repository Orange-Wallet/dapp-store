import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_info_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_list_dto.dart';

class RemoteDataSource {
  Future<DappListDto> getDappList() async {
    await Network().get();
    //dio api call
    return DappListDto();
  }

  Future<DappInfoDto> getDappInfo(String ID) async {
    await Network().get();
    //dio api call
    return DappInfoDto();
  }

  Future<List<DappInfoDto>> searchDapps(String searchString) async {
    await Network().get();
    //dio api call
    return [DappInfoDto()];
  }
}
