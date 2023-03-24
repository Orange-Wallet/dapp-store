import 'dart:developer';

import 'package:dappstore/features/dapp_info/application/i_dapp_info_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part '../../../generated/features/dapp_info/application/dapp_info_cubit.freezed.dart';
part '../../../generated/features/dapp_info/application/dapp_info_cubit.g.dart';

part 'dapp_info_state.dart';

class DappInfoCubit extends Cubit<DappInfoState> implements IDappInfoCubit {
  final IStoreCubit storeCubit;
  DappInfoCubit({required this.storeCubit}) : super(DappInfoState.initial()) {
    final dappInfo = storeCubit.getActiveDappInfo;
    emit(state.copyWith(
        activeDappId: storeCubit.state.activeDappId, dappInfo: dappInfo));
    getDappInfo(
        queryParams:
            GetDappInfoQueryDto(dappId: storeCubit.state.activeDappId));
  }

  @override
  Future<void> close() {
    return super.close();
  }

  @override
  Future<DappInfo?> getDappInfo({GetDappInfoQueryDto? queryParams}) async {
    DappInfo? dappInfo = await storeCubit.getDappInfo(queryParams: queryParams);
    log(dappInfo.toString());
    if (dappInfo != null) {
      emit(state.copyWith(dappInfo: dappInfo));
    }
    return dappInfo;
  }
}
