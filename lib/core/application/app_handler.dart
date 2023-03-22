import 'package:dappstore/core/application/i_app_handler.dart';
import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/localisation/i_localisation_cubit.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAppHandler)
class AppHandler implements IAppHandler {
  @override
  IThemeCubit get themeCubit => getIt<IThemeCubit>();

  @override
  ILocaleCubit get localeCubit => getIt<ILocaleCubit>();

  @override
  setDarkTheme() {
    themeCubit.setDarkTheme();
  }

  @override
  setLightTheme() {
    themeCubit.setLightTheme();
  }

  @override
  bool get isFollowingSystemBrightness =>
      getIt<IThemeCubit>().state.shouldFollowSystem ?? false;
}
