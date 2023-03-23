import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/curated_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/repositories/i_dapp_list_repository.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/datasources/i_data_source.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/datasources/local_data_source.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/curated_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_info_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IDappListRepo)
class DappListRepoImpl implements IDappListRepo {
  late final Network _network = Network(dioClient: Dio());
  late final IDataSource _dataSource = LocalDataSource(network: _network);

  DappListRepoImpl();

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
}
