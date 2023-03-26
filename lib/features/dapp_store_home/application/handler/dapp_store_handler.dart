import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';

class DappStoreHandler implements IDappStoreHandler {
  @override
  IStoreCubit getStoreCubit() {
    return getIt<IStoreCubit>();
  }

  @override
  started() async {
    await getStoreCubit().started();
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

  @override
  IThemeSpec get theme => getIt<IThemeCubit>().theme;

  @override
  getCuratedCategoryList() {
    getStoreCubit().getCuratedCategoryList();
  }

  @override
  getFeaturedDappsByCategory({required String category}) {
    getStoreCubit().getFeaturedDappsByCategory(category: category);
  }

  @override
  getFeaturedDappsList() {
    getStoreCubit().getFeaturedDappsList();
  }

  @override
  getSelectedCategoryDappList({required GetDappQueryDto queryParams}) {
    getStoreCubit().getSelectedCategoryDappList(queryParams: queryParams);
  }

  @override
  getSelectedCategoryDappListNextPage() {
    getStoreCubit().getSelectedCategoryDappListNextPage();
  }

  @override
  resetSelectedCategory() {
    getStoreCubit().resetSelectedCategory();
  }
}
