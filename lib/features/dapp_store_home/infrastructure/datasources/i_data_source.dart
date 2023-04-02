import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/build_url_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/curated_category_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/curated_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_info_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';

abstract class IDataSource {
  Future<DappListDto> getDappList({
    GetDappQueryDto? queryParams,
  });

  Future<DappInfoDto?> getDappInfo({GetDappInfoQueryDto? queryParams});

  Future<List<DappInfoDto>> searchDapps(String searchString);

  Future<List<CuratedListDto>> getCuratedList();
  Future<List<CuratedCategoryListDto>> getCuratedCategoryList();
  Future<DappListDto> getFeaturedDappsList();
  Future<DappListDto> getFeaturedDappsByCategory({required String category});
  Future<BuildUrlDto> getBuildUrl(String dappId);
  String getPwaRedirectionUrl(String dappId, String walletAddress);
  Future<DappListDto> getDappsByPackageId(List<String> packageIds);
}
