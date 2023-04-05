import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/core/store/i_cache_store.dart';
import 'package:dappstore/features/self_update/infrastructure/datasources/i_data_sources.dart';
import 'package:dappstore/features/self_update/infrastructure/datasources/remote_data_source.dart';
import 'package:dappstore/features/self_update/infrastructure/models/self_update_model.dart';
import 'package:dappstore/features/self_update/infrastructure/models/self_update_store_model.dart';
import 'package:dappstore/features/self_update/infrastructure/repositories/i_self_update_repository.dart';
import 'package:dappstore/features/self_update/infrastructure/store/i_self_update_store.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISelfUpdateRepo)
class SelfUpdateRepoImpl implements ISelfUpdateRepo {
  final ICacheStore cacheStore;
  late final Network _network =
      Network(dioClient: Dio(), interceptors: cacheStore.dioCacheInterceptor);
  late final IDataSource _dataSource = RemoteDataSource(network: _network);
  @override
  final ISelfUpdateStore SelfUpdateStore;

  SelfUpdateRepoImpl({required this.SelfUpdateStore, required this.cacheStore});

  @override
  Future<SelfUpdateModel?> getSelfUpdate({required String address}) async {
    SelfUpdateStoreModel? selfUpdateStoreModel =
        await SelfUpdateStore.getSelfUpdate(address);
    if (selfUpdateStoreModel != null) {
      return SelfUpdateModel.fromStoreModel(selfUpdateStoreModel);
    } else {
      return _dataSource.getSelfUpdate(address: address);
    }
  }

  @override
  Future<bool> postSelfUpdate(
      {required SelfUpdateModel selfUpdateModel}) async {
    bool res =
        await _dataSource.postSelfUpdate(selfUpdateModel: selfUpdateModel);
    if (res) {
      await SelfUpdateStore.addSelfUpdate(
          model: selfUpdateModel.toStoreModel());
    }
    return res;
  }
}
