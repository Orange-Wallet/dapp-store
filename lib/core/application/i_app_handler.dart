import 'package:dappstore/core/theme/i_theme_cubit.dart';

abstract class IAppHandler {
  IThemeCubit get themeCubit;
  setDarkTheme();
  setLightTheme() {
    themeCubit.setLightTheme();
  }

  bool get isFollowingSystemBrightness;
}
