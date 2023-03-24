import 'package:dappstore/features/dapp_info/application/dapp_info_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class IDappInfoCubit extends Cubit<DappInfoState> {
  IDappInfoCubit() : super(DappInfoState.initial());

  Future<DappInfo?> getDappInfo({GetDappInfoQueryDto? queryParams});
}
