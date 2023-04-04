import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';
import 'package:dappstore/features/saved_dapps/application/i_saved_dapps_cubit.dart';

abstract class IDappStoreHandler {
  ISavedDappsCubit get savedDappsCubit;

  IStoreCubit getStoreCubit();

  IThemeSpec get theme;

  started();
  getDappList();

  getDappListNextPage();

  getDappInfo({GetDappInfoQueryDto? queryParams});

  getCuratedList();

  getSearchDappList({required GetDappQueryDto queryParams});

  getSearchDappListNextPage();

  getCuratedCategoryList();

  getFeaturedDappsList();

  getFeaturedDappsByCategory({required String category});

  getSelectedCategoryDappList({required GetDappQueryDto queryParams});

  getSelectedCategoryDappListNextPage();

  resetSelectedCategory();

  setActiveDappId({required String dappId});
}
