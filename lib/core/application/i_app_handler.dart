import 'package:dappstore/core/localisation/i_localisation_cubit.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';

abstract class IAppHandler {
  IThemeCubit get themeCubit;
  ILocaleCubit get localeCubit;

  setDarkTheme();
  setLightTheme() {
    themeCubit.setLightTheme();
  }

  bool get isFollowingSystemBrightness;
}
