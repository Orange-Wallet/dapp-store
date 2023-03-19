import 'package:dappstore/config/config.dart';
import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/core/network/response_model.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_info_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';

class RemoteDataSource {
  final Network _network;
  RemoteDataSource({required Network network}) : _network = network;

  Future<DappListDto> getDappList({
    GetDappQueryDto? queryParams,
  }) async {
    ResponseModel res = await _network.get(
        path: "${Config.registryApiBaseUrl}/dapp",
        queryParams: queryParams?.toJson());

    return DappListDto.fromJson(res.body);
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
