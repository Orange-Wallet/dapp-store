import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/core/store/i_cache_store.dart';
import 'package:dappstore/features/profile/infrastructure/datasources/i_data_sources.dart';
import 'package:dappstore/features/profile/infrastructure/datasources/remote_data_source.dart';
import 'package:dappstore/features/profile/infrastructure/repositories/i_profile_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IProfileRepo)
class ProfileRepoImpl implements IProfileRepo {
  final ICacheStore cacheStore;
  late final Network _network =
      Network(dioClient: Dio(), interceptors: cacheStore.dioCacheInterceptor);
  late final IDataSource _dataSource = RemoteDataSource(network: _network);

  ProfileRepoImpl({required this.cacheStore});
}
