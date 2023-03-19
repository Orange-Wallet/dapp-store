import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_list.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/datasources/remote_data_source.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_info_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_list_dto.dart';

class DappListRepository {
  Future<DappList> getDappList() async {
    final DappListDto dappList =
        await RemoteDataSource().getDappList(); // from remote data source
    return DappListDto().toDomain();
  }

  Future<DappInfo> getDappInfo(String ID) async {
    final DappInfoDto dappList =
        await RemoteDataSource().getDappInfo(ID); // from remote data source
    return DappInfoDto().toDomain();
  }

  Future<List<DappInfo>> searchDapps(String searchString) async {
    final List<DappInfoDto> dappList = await RemoteDataSource()
        .searchDapps(searchString); // from remote data source
    final List<DappInfo> list = [];
    dappList.forEach((element) {
      list.add(element.toDomain());
    });
    return list;
  }
}
