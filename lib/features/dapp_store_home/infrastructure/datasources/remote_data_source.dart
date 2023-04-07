import 'dart:developer';

import 'package:dappstore/config/config.dart';
import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
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
  Future<DappListDto?> getDappList({
    GetDappQueryDto? queryParams,
  }) async {
    try {
      Response res = await _network.get(
          path: "${Config.registryApiBaseUrl}/dapp",
          queryParams: queryParams?.toJson());

      return DappListDto.fromJson(res.data);
    } catch (e, stack) {
      // TODO catch exception
      log("${e.toString()} : $stack ");
    }
    return null;
  }

  @override
  Future<DappInfoDto?> getDappInfo({GetDappInfoQueryDto? queryParams}) async {
    try {
      //TODO needs to test properly
      Response res = await _network.get(
          path: "${Config.glApiBaseUrl}/api/v1/dapp/searchById",
          queryParams: queryParams?.toJson());
      return DappInfoDto.fromJson(res.data[0]);
    } catch (e, stack) {
      // TODO catch exception
      log("${e.toString()} : $stack ");
    }
    return null;
  }

  @override
  Future<List<DappInfoDto>?> searchDapps(String searchString) async {
    //dio api call
    try {
      return [DappInfoDto()];
    } catch (e, stack) {
      // TODO catch exception
      log("${e.toString()} : $stack ");
    }
    return null;
  }

  @override
  Future<List<CuratedListDto>> getCuratedList() async {
    // not used anymore
    Response res = await _network.get(
      path: "${Config.registryApiBaseUrl}/store/featured",
    );
    List<CuratedListDto> list =
        (res.data as List).map((i) => CuratedListDto.fromJson(i)).toList();
    return list;
  }

  @override
  Future<List<CuratedCategoryListDto>?> getCuratedCategoryList() async {
    try {
      Response res = await _network.get(
        path: "${Config.glApiBaseUrl}/api/v1/categories",
      );
      List<CuratedCategoryListDto> list = (res.data as List)
          .map((e) => CuratedCategoryListDto.fromJson(e))
          .toList();
      return list;
    } catch (e, stack) {
      // TODO catch exception
      log("${e.toString()} : $stack ");
    }
    return null;
  }

  @override
  Future<DappListDto?> getFeaturedDappsByCategory(
      {required String category}) async {
    //TODO implement breaking

    try {
      Response res = await _network.get(
          path: "${Config.registryApiBaseUrl}/dapp",
          queryParams: GetDappQueryDto(limit: 20).toJson()
          // path: "${Config.glApiBaseUrl}/api/v1/categories/categorydapps",
          // queryParams:
          //     GetDappQueryDto(limit: 20, categories: [category]).toJson(),
          );

      return DappListDto.fromJson(res.data);
    } catch (e, stack) {
      // TODO catch exception
      log("${e.toString()} : $stack ");
    }
    return null;
  }

  @override
  Future<DappListDto?> getFeaturedDappsList() async {
    //TODO implement breaking
    try {
      Response res = await _network.get(
        path: "${Config.glApiBaseUrl}/api/v1/store/featured",
        queryParams: GetDappQueryDto(limit: 20).toJson(),
      );

      return DappListDto.fromJson(res.data);
    } catch (e, stack) {
      // TODO catch exception
      log("${e.toString()} : $stack ");
    }
    return null;
  }

  //TODO: add address here
  @override
  Future<BuildUrlDto?> getBuildUrl(
    String dappId,
  ) async {
    try {
      final url = "${Config.registryApiBaseUrl}/dapp/$dappId/build";
      Response res = await _network.get(
        path: url,
      );

      return BuildUrlDto.fromJson(res.data);
    } catch (e, stack) {
      // TODO catch exception
      log("${e.toString()} : $stack ");
    }
    return null;
  }

  //TODO: implement this
  @override
  Future<Map<String, DappInfo?>> getDappsByPackageId(
      List<String> packageIds) async {
    try {
      Response res = await _network.get(
          path: "${Config.registryApiBaseUrl}/api/v1/dapp/queryWithPackageId",
          queryParams: {"packageId": packageIds});
      final data = res.data["response"] as Map<String, dynamic>;
      final Map<String, DappInfo> mapping = {};
      data.forEach((key, value) {
        mapping[key] = DappInfo.fromJson(value);
      });
      return mapping;
    } catch (e, stack) {
      // TODO catch exception
      log("${e.toString()} : $stack ");
    }
    return {};
  }

  @override
  String getPwaRedirectionUrl(String dappId, String walletAddress) {
    return "${Config.registryApiBaseUrl}/o/view/$dappId?userAddress=$walletAddress";
  }
}
