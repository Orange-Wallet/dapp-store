import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/saved_pwa/application/i_saved_pwa_cubit.dart';

abstract class ISavedPwaPageHandler {
  IThemeCubit get themeCubit;
  IStoreCubit get storeCubit;
  ISavedPwaCubit get savedPwaCubit;
}
