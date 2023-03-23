import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/domain/repositories/i_dapp_list_repository.dart';

abstract class IDappInfoHandler {
  IThemeCubit get themeCubit;
  IStoreCubit get storeCubit;
  Future<DappInfo> dappInfo(String id);
}
