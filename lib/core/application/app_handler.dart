import 'package:dappstore/core/application/i_app_handler.dart';
import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAppHandler)
class AppHandler implements IAppHandler {
  @override
  IThemeCubit get themeCubit => getIt<IThemeCubit>();
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
