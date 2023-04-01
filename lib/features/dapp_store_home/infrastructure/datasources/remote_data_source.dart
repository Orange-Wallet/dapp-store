import 'package:dappstore/config/config.dart';
import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/datasources/i_data_source.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/build_url_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/curated_category_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/curated_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_info_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';
import 'package:dio/dio.dart';

class RemoteDataSource implements IDataSource {
  final Network _network;
  RemoteDataSource({required Network network}) : _network = network;

  @override
  Future<DappListDto> getDappList({
    GetDappQueryDto? queryParams,
  }) async {
    Response res = await _network.get(
        path: "${Config.registryApiBaseUrl}/dapp",
        queryParams: queryParams?.toJson());

    return DappListDto.fromJson(res.data);
  }

  @override
  Future<DappInfoDto> getDappInfo({GetDappInfoQueryDto? queryParams}) async {
    Response res = await _network.get(
        path: "${Config.registryApiBaseUrl}/dapp/searchById",
        queryParams: queryParams?.toJson());
    return DappInfoDto.fromJson(res.data[0]);
  }

  @override
  Future<List<DappInfoDto>> searchDapps(String searchString) async {
    //dio api call
    return [DappInfoDto()];
  }

  @override
  Future<List<CuratedListDto>> getCuratedList() async {
    Response res = await _network.get(
      path: "${Config.registryApiBaseUrl}/store/featured",
    );
    List<CuratedListDto> list =
        (res.data as List).map((i) => CuratedListDto.fromJson(i)).toList();
    return list;
  }

  @override
  Future<List<CuratedCategoryListDto>> getCuratedCategoryList() {
    // TODO: implement getCuratedCategoryList
    throw UnimplementedError();
  }

  @override
  Future<DappListDto> getFeaturedDappsByCategory(
      {required String category}) async {
    //TODO implement

    Response res = await _network.get(
        path: "${Config.registryApiBaseUrl}/dapp",
        queryParams: GetDappQueryDto(limit: 20).toJson());

    return DappListDto.fromJson(res.data);
  }

  @override
  Future<DappListDto> getFeaturedDappsList() async {
    //TODO implement
    Response res = await _network.get(
        path: "${Config.registryApiBaseUrl}/dapp",
        queryParams: GetDappQueryDto(limit: 20).toJson());

    return DappListDto.fromJson(res.data);
  }

  //todo: add address here
  @override
  Future<BuildUrlDto> getBuildUrl(String dappId) async {
    Response res = await _network.get(
      path: "${Config.registryApiBaseUrl}/dapp/$dappId/build",
    );

    return BuildUrlDto.fromJson(res.data);
  }

  //todo: implement this
  @override
  Future<DappInfoDto> getDappsByPackageId(List<String> packageIds) async {
    Response res = await _network.get(
        path: "${Config.registryApiBaseUrl}/dapp/searchByPackageId",
        queryParams: {"packageId": packageIds});
    return DappInfoDto.fromJson(res.data[0]);
  }

  @override
  String getPwaRedirectionUrl(String dappId, String walletAddress) {
    return "${Config.registryApiBaseUrl}/o/view/$dappId?userAddress=$walletAddress";
  }
}
