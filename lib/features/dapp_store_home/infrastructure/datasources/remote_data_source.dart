import 'package:dappstore/config/config.dart';
import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/curated_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_info_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';
import 'package:dio/dio.dart';

class RemoteDataSource {
  final Network _network;
  RemoteDataSource({required Network network}) : _network = network;

  Future<DappListDto> getDappList({
    GetDappQueryDto? queryParams,
  }) async {
    Response res = await _network.get(
        path: "${Config.registryApiBaseUrl}/dapp",
        queryParams: queryParams?.toJson());

    return DappListDto.fromJson(res.data);
  }

  Future<DappInfoDto> getDappInfo({GetDappInfoQueryDto? queryParams}) async {
    Response res = await _network.get(
        path: "${Config.registryApiBaseUrl}/dapp/searchById",
        queryParams: queryParams?.toJson());
    return DappInfoDto.fromJson(res.data[0]);
  }

  Future<List<DappInfoDto>> searchDapps(String searchString) async {
    //dio api call
    return [DappInfoDto()];
  }

  Future<List<CuratedListDto>> getCuratedList() async {
    Response res = await _network.get(
      path: "${Config.registryApiBaseUrl}/store/featured",
    );
    List<CuratedListDto> list =
        (res.data as List).map((i) => CuratedListDto.fromJson(i)).toList();
    return list;
  }
}
