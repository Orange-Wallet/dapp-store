import 'package:dappstore/features/dapp_store_home/domain/entities/curated_category_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/curated_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_list.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';

abstract class IDappListRepo {
  Future<DappList> getDappList({GetDappQueryDto? queryParams});

  Future<DappInfo?> getDappInfo({GetDappInfoQueryDto? queryParams});

  Future<List<CuratedList>> getCuratedList();
  Future<List<DappInfo>> searchDapps(String searchString);
  Future<List<CuratedCategoryList>> getCuratedCategoryList();
  Future<DappList> getFeaturedDappsList();
  Future<DappList> getFeaturedDappsByCategory({required String category});
}
