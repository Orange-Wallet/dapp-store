import 'dart:developer';

import 'package:dappstore/features/dapp_info/application/i_dapp_info_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/post_rating.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part '../../../generated/features/dapp_info/application/dapp_info_cubit.freezed.dart';
part '../../../generated/features/dapp_info/application/dapp_info_cubit.g.dart';
part 'dapp_info_state.dart';

@LazySingleton(as: IDappInfoCubit)
class DappInfoCubit extends Cubit<DappInfoState> implements IDappInfoCubit {
  final IStoreCubit storeCubit;
  final IWalletConnectCubit walletConnectCubit;
  DappInfoCubit({
    required this.storeCubit,
    required this.walletConnectCubit,
  }) : super(DappInfoState.initial()) {
    final dappInfo = storeCubit.getActiveDappInfo;
    if (dappInfo != null) {
      emit(state.copyWith(
          activeDappId: storeCubit.state.activeDappId, dappInfo: dappInfo));
    } else {
      if (storeCubit.state.activeDappId != null) {
        getDappInfo(
            queryParams:
                GetDappInfoQueryDto(dappId: storeCubit.state.activeDappId));
      }
    }
    storeCubit.getRating(dappId: storeCubit.state.activeDappId!).then((value) {
      emit(state.copyWith(ratings: value));
    });
    storeCubit
        .getUserRating(
            dappId: storeCubit.state.activeDappId!,
            address: walletConnectCubit.getActiveAdddress() ?? "")
        .then((value) {
      emit(state.copyWith(selfRating: value));
    });
  }

  @override
  Future<void> close() {
    return super.close();
  }

  @override
  Future<DappInfo?> getDappInfo({GetDappInfoQueryDto? queryParams}) async {
    emit(state.copyWith(loading: true));

    DappInfo? dappInfo = await storeCubit.getDappInfo(queryParams: queryParams);
    log(dappInfo.toString());
    if (dappInfo != null) {
      emit(state.copyWith(dappInfo: dappInfo, loading: false));
    }
    return dappInfo;
  }

  @override
  Future<bool> updateUserRating({required PostRating data}) async {
    emit(state.copyWith(
      selfRating: data,
    ));
    return true;
  }
}
