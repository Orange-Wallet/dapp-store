// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dappstore/core/application/app_handler.dart' as _i7;
import 'package:dappstore/core/application/i_app_handler.dart' as _i6;
import 'package:dappstore/core/error/error_logger.dart' as _i11;
import 'package:dappstore/core/error/i_error_logger.dart' as _i10;
import 'package:dappstore/core/installed_apps/i_installed_apps_cubit.dart'
    as _i12;
import 'package:dappstore/core/installed_apps/installed_apps_cubit.dart'
    as _i13;
import 'package:dappstore/core/localisation/i_localisation_cubit.dart' as _i39;
import 'package:dappstore/core/localisation/localisation_cubit.dart' as _i40;
import 'package:dappstore/core/localisation/store/i_localisation_store.dart'
    as _i16;
import 'package:dappstore/core/localisation/store/localisation_store.dart'
    as _i17;
import 'package:dappstore/core/permissions/i_permissions_cubit.dart' as _i18;
import 'package:dappstore/core/permissions/permissions_cubit.dart' as _i19;
import 'package:dappstore/core/platform_channel/i_platform_channel_cubit.dart'
    as _i20;
import 'package:dappstore/core/platform_channel/platform_channel_cubit.dart'
    as _i21;
import 'package:dappstore/core/router/custom_route_observer.dart' as _i3;
import 'package:dappstore/core/theme/i_theme_cubit.dart' as _i45;
import 'package:dappstore/core/theme/store/i_theme_store.dart' as _i30;
import 'package:dappstore/core/theme/store/theme_store.dart' as _i31;
import 'package:dappstore/core/theme/theme_cubit.dart' as _i46;
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart'
    as _i28;
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart'
    as _i29;
import 'package:dappstore/features/dapp_store_home/domain/repositories/i_dapp_list_repository.dart'
    as _i8;
import 'package:dappstore/features/dapp_store_home/infrastructure/repositories/dapp_list_repository_impl.dart'
    as _i9;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/downloader/downloader_cubit.dart'
    as _i36;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/downloader/i_downloader_cubit.dart'
    as _i35;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/foreground_service/foreground_service_cubit.dart'
    as _i38;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/foreground_service/i_foreground_service_cubit.dart'
    as _i37;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/installer/i_installer_cubit.dart'
    as _i14;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/installer/installer_cubit.dart'
    as _i15;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart'
    as _i41;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/package_manager_cubit.dart'
    as _i42;
import 'package:dappstore/features/pwa_webwiew/application/handler/i_pwa_webview_handler.dart'
    as _i24;
import 'package:dappstore/features/pwa_webwiew/application/handler/pwa_webview_handler.dart'
    as _i25;
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/i_injected_web3_cubit.dart'
    as _i49;
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit.dart'
    as _i50;
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/i_pwa_webview_cubit.dart'
    as _i22;
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit.dart'
    as _i23;
import 'package:dappstore/features/saved_pwa/application/i_saved_pwa_cubit.dart'
    as _i43;
import 'package:dappstore/features/saved_pwa/application/saved_pwa_cubit.dart'
    as _i44;
import 'package:dappstore/features/saved_pwa/infrastructure/store/i_saved_pwa_store.dart'
    as _i26;
import 'package:dappstore/features/saved_pwa/infrastructure/store/saved_pwa_store.dart'
    as _i27;
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart'
    as _i47;
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/wallet_connect_cubit.dart'
    as _i48;
import 'package:dappstore/features/wallet_connect/infrastructure/store/i_wallet_connect_store.dart'
    as _i32;
import 'package:dappstore/features/wallet_connect/infrastructure/store/wallet_connect_store.dart'
    as _i33;
import 'package:dappstore/features/wallet_connect/infrastructure/wallet_connect.dart'
    as _i34;
import 'package:dappstore/widgets/buttons/app_button_handler/app_button_handler.dart'
    as _i5;
import 'package:dappstore/widgets/buttons/app_button_handler/i_app_button_handler.dart'
    as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.CustomRouteObserver>(() => _i3.CustomRouteObserver());
  gh.lazySingleton<_i4.IAppButtonHandler>(() => _i5.AppButtonHandler());
  gh.lazySingleton<_i6.IAppHandler>(() => _i7.AppHandler());
  gh.lazySingleton<_i8.IDappListRepo>(() => _i9.DappListRepoImpl());
  gh.lazySingleton<_i10.IErrorLogger>(() => _i11.ErrorLogger());
  gh.lazySingleton<_i12.IInstalledAppsCubit>(() => _i13.InstalledAppsCubit());
  gh.lazySingleton<_i14.IInstallerCubit>(() => _i15.InstallerCubit());
  gh.lazySingleton<_i16.ILocalisationStore>(() => _i17.LocalisationStore());
  gh.lazySingleton<_i18.IPermissions>(() => _i19.Permissions());
  gh.lazySingleton<_i20.IPlatformChannelCubit>(
      () => _i21.PlatformChannelCubit());
  gh.lazySingleton<_i22.IPwaWebviewCubit>(() => _i23.PwaWebviewCubit());
  gh.lazySingleton<_i24.IPwaWebviewHandler>(() => _i25.PwaWebviewHandler());
  gh.lazySingleton<_i26.ISavedPwaStore>(
      () => _i27.SavedPwaStore(errorLogger: gh<_i10.IErrorLogger>()));
  gh.lazySingleton<_i28.IStoreCubit>(
      () => _i29.StoreCubit(dappListRepo: gh<_i8.IDappListRepo>()));
  gh.lazySingleton<_i30.IThemeStore>(() => _i31.ThemeStore());
  gh.lazySingleton<_i32.IWalletConnectStore>(
      () => _i33.WalletConnectStore(errorLogger: gh<_i10.IErrorLogger>()));
  gh.lazySingleton<_i34.WalletConnect>(() => _i34.WalletConnect());
  gh.lazySingleton<_i35.IDownloader>(() => _i36.DownloaderCubit(
        permissionsCubit: gh<_i18.IPermissions>(),
        installerCubit: gh<_i14.IInstallerCubit>(),
      ));
  gh.lazySingleton<_i37.IForegroundService>(() => _i38.ForegroundService(
      platformChannelCubit: gh<_i20.IPlatformChannelCubit>()));
  gh.lazySingleton<_i39.ILocaleCubit>(
      () => _i40.LocaleCubit(localisationStore: gh<_i16.ILocalisationStore>()));
  gh.lazySingleton<_i41.IPackageManager>(() => _i42.PackageManager(
        gh<_i14.IInstallerCubit>(),
        gh<_i35.IDownloader>(),
        gh<_i37.IForegroundService>(),
        gh<_i12.IInstalledAppsCubit>(),
      ));
  gh.lazySingleton<_i43.ISavedPwaCubit>(
      () => _i44.SavedPwaCubit(savedPwaStore: gh<_i26.ISavedPwaStore>()));
  gh.lazySingleton<_i45.IThemeCubit>(
      () => _i46.ThemeCubit(themeStore: gh<_i30.IThemeStore>()));
  gh.lazySingleton<_i47.IWalletConnectCubit>(() => _i48.WalletConnectCubit(
        errorLogger: gh<_i10.IErrorLogger>(),
        wcStore: gh<_i32.IWalletConnectStore>(),
      ));
  gh.lazySingleton<_i49.IInjectedWeb3Cubit>(() => _i50.InjectedWeb3Cubit(
        signer: gh<_i47.IWalletConnectCubit>(),
        errorLogger: gh<_i10.IErrorLogger>(),
      ));
  return getIt;
}
