import 'package:dappstore/config/config.dart';
import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/datasources/i_data_source.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/curated_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_info_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';
import 'package:dio/dio.dart';

class LocalDataSource implements IDataSource {
  final Network _network;
  LocalDataSource({required Network network}) : _network = network;

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
  Future<DappInfoDto?> getDappInfo({GetDappInfoQueryDto? queryParams}) async {
    return DappInfoDto.fromJson({
      "name": "Axie Infinity",
      "description":
          "Axie Infinity is a Pokemon-inspired digital pet universe where players use their cute characters called Axies in various games. The Axie Infinity Universe highlights the benefits of blockchain technology through \"Free to Play to Earn\" gameplay and a player-owned economy.",
      "appUrl": "https://axieinfinity.com/",
      "images": {
        "logo":
            "https://dashboard-assets.dappradar.com/document/9495/axieinfinity-dapp-games-ronin-logo_1ec806d57fd80ab68d351658cb8d146a.png"
      },
      "minAge": 13,
      "isForMatureAudience": false,
      "isSelfModerated": true,
      "language": "en",
      "version": "unknown",
      "isListed": true,
      "listDate": "2023-01-30",
      "availableOnPlatform": ["web"],
      "category": "games",
      "chains": [1],
      "dappId": "com.axieinfinity.dapp",
      "metrics": {
        "dappId": "com.axieinfinity.dapp",
        "downloads": 0,
        "installs": 0,
        "uninstalls": 0,
        "ratingsCount": 0,
        "visits": 0,
        "rating": null
      }
    });
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
}
