import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_list.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/datasources/remote_data_source.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_info_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_list_dto.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DappListRepoImpl {
  final Network _network;
  final RemoteDataSource _remoteDataSource;

  DappListRepoImpl({required Network network})
      : _network = network,
        _remoteDataSource = RemoteDataSource(network: network);

  Future<DappList> getDappList() async {
    final DappListDto dappList =
        await _remoteDataSource.getDappList(); // from remote data source
    return const DappListDto().toDomain();
  }

  Future<DappInfo> getDappInfo(String ID) async {
    final DappInfoDto dappList =
        await _remoteDataSource.getDappInfo(ID); // from remote data source
    return DappInfoDto().toDomain();
  }

  Future<List<DappInfo>> searchDapps(String searchString) async {
    final List<DappInfoDto> dappList = await _remoteDataSource
        .searchDapps(searchString); // from remote data source
    final List<DappInfo> list = [];
    dappList.forEach((element) {
      list.add(element.toDomain());
    });
    return list;
  }
}
