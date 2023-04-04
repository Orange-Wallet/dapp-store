import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/features/profile/infrastructure/datasources/i_data_sources.dart';
import 'package:dappstore/features/profile/infrastructure/datasources/remote_data_source.dart';
import 'package:dappstore/features/profile/infrastructure/repositories/i_profile_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IProfileRepo)
class ProfileRepoImpl implements IProfileRepo {
  late final Network _network = Network(dioClient: Dio());
  late final IDataSource _dataSource = RemoteDataSource(network: _network);

  ProfileRepoImpl();
}
