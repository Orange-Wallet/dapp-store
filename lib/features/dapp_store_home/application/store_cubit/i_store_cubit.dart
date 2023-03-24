import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/domain/repositories/i_dapp_list_repository.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/repositories/dapp_list_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class IStoreCubit extends Cubit<StoreState> {
  IDappListRepo dappListRepo;
  IStoreCubit({required DappListRepoImpl this.dappListRepo})
      : super(StoreState.initial());

  @override
  Future<void> close();

  started();

  getDappList();

  getDappListNextPage();

  getDappInfo({GetDappInfoQueryDto? queryParams});

  getCuratedList();

  getSearchDappList({required GetDappQueryDto queryParams});

  getSearchDappListNextPage();

  setActiveDappId({required String dappId});

  DappInfo? get getActiveDappInfo;
}
