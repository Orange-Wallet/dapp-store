import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/dapp_info/application/i_dapp_info_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';

abstract class IDappInfoHandler {
  IThemeCubit get themeCubit;
  IStoreCubit get storeCubit;
  IDappInfoCubit get dappInfoCubit;
}
