import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';

class DappStoreHandler implements IDappStoreHandler {
  @override
  IStoreCubit getStoreCubit() {
    return getIt<StoreCubit>();
  }

  @override
  getCuratedList() {
    getStoreCubit().getCuratedList();
  }

  @override
  getDappInfo({GetDappInfoQueryDto? queryParams}) {
    getStoreCubit().getDappInfo(queryParams: queryParams);
  }

  @override
  getDappList() {
    getStoreCubit().getDappList();
  }

  @override
  getDappListNextPage() {
    getStoreCubit().getDappListNextPage();
  }

  @override
  getSearchDappList({required GetDappQueryDto queryParams}) {
    getStoreCubit().getSearchDappList(queryParams: queryParams);
  }

  @override
  getSearchDappListNextPage() {
    getStoreCubit().getSearchDappListNextPage();
  }
}
