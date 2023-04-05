import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/core/store/cache_store.dart';
import 'package:dappstore/core/store/i_cache_store.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/curated_category_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/curated_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/repositories/i_dapp_list_repository.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/datasources/i_data_source.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/datasources/local_data_source.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/datasources/remote_data_source.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/build_url_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/curated_category_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/curated_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_info_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IDappListRepo)
class DappListRepoImpl implements IDappListRepo {
  final ICacheStore cacheStore;
  late final Network _network;
  late final IDataSource _dataSource = RemoteDataSource(network: _network);
  late final IDataSource _localDataSource = LocalDataSource(network: _network);
  DappListRepoImpl({required this.cacheStore}) {
    _network = Network(
      dioClient: Dio(),
      interceptors: cacheStore.dioCacheInterceptor,
    );
  }

  @override
  Future<DappList> getDappList({GetDappQueryDto? queryParams}) async {
    final DappListDto dappList = await _dataSource.getDappList(
        queryParams: queryParams); // from remote data source
    return dappList.toDomain();
  }

  @override
  Future<DappInfo?> getDappInfo({GetDappInfoQueryDto? queryParams}) async {
    final DappInfoDto? dappInfo = await _dataSource.getDappInfo(
        queryParams: queryParams); // from remote data source
    return dappInfo?.toDomain();
  }

  @override
  Future<List<CuratedList>> getCuratedList() async {
    final List<CuratedListDto> curatedList = await _dataSource.getCuratedList();
    final List<CuratedList> list = [];
    for (var element in curatedList) {
      list.add(element.toDomain());
    }
    return list;
  }

  @override
  Future<List<CuratedCategoryList>> getCuratedCategoryList() async {
    final List<CuratedCategoryListDto> curatedCategoryList =
        await _localDataSource.getCuratedCategoryList();
    final List<CuratedCategoryList> list = [];
    for (var element in curatedCategoryList) {
      list.add(element.toDomain());
    }
    return list;
  }

  @override
  Future<DappList> getFeaturedDappsByCategory(
      {required String category}) async {
    final DappListDto dappList =
        await _dataSource.getFeaturedDappsByCategory(category: category);
    return dappList.toDomain();
  }

  @override
  Future<DappList> getFeaturedDappsList() async {
    final DappListDto dappList = await _dataSource.getFeaturedDappsList();
    return dappList.toDomain();
  }

  @override
  Future<String?> getBuildUrl(String dappId) async {
    final BuildUrlDto dto = await _dataSource.getBuildUrl(dappId);
    if (dto.success ?? false) {
      return dto.url;
    }
    return null;
  }

  @override
  String getPwaRedirectionUrl(String dappId, String walletAddress) {
    final String url =
        _localDataSource.getPwaRedirectionUrl(dappId, walletAddress);
    return url;
  }

  @override
  Future<DappList> queryWithPackageId(
      {required List<String> pacakgeIds}) async {
    final DappListDto dappListDto =
        await _localDataSource.getDappsByPackageId(pacakgeIds);
    return dappListDto.toDomain();
  }
}
