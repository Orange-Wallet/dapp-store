import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_list.dart';

abstract class IDappListRepository {
  Future<DappList> getDappList();

  Future<DappInfo> getDappInfo(String ID);

  Future<List<DappInfo>> searchDapps(String searchString);
}
