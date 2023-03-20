import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';

abstract class IDappStoreHandler {
  IStoreCubit getStoreCubit();
  getDappList();

  getDappListNextPage();

  getDappInfo({GetDappInfoQueryDto? queryParams});

  getCuratedList();

  getSearchDappList({required GetDappQueryDto queryParams});

  getSearchDappListNextPage();
}
