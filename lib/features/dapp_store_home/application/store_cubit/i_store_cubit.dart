import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/repositories/i_dapp_list_repository.dart';
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
}
