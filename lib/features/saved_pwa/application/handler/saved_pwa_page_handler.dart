import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/saved_pwa/application/handler/i_saved_pwa_page_handler.dart';
import 'package:dappstore/features/saved_pwa/application/i_saved_pwa_cubit.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISavedPwaPageHandler)
class SavedPwaPageHandler implements ISavedPwaPageHandler {
  @override
  IThemeCubit get themeCubit => getIt<IThemeCubit>();
  @override
  IStoreCubit get storeCubit => getIt<IStoreCubit>();
  @override
  ISavedPwaCubit get savedPwaCubit => getIt<ISavedPwaCubit>();
}
