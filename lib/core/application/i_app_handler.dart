import 'package:dappstore/core/localisation/i_localisation_cubit.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';

abstract class IAppHandler {
  IThemeCubit get themeCubit;

  ILocaleCubit get localeCubit;

  IPackageManager get packageManager;

  setDarkTheme();

  setLightTheme() {
    themeCubit.setLightTheme();
  }

  bool get isFollowingSystemBrightness;

  get reloadPackages;
}
