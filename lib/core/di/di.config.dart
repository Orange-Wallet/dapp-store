// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dappstore/core/application/app_handler.dart' as _i7;
import 'package:dappstore/core/application/i_app_handler.dart' as _i6;
import 'package:dappstore/core/error/error_logger.dart' as _i13;
import 'package:dappstore/core/error/i_error_logger.dart' as _i12;
import 'package:dappstore/core/installed_apps/i_installed_apps_cubit.dart'
    as _i14;
import 'package:dappstore/core/installed_apps/installed_apps_cubit.dart'
    as _i15;
import 'package:dappstore/core/localisation/i_localisation_cubit.dart' as _i48;
import 'package:dappstore/core/localisation/localisation_cubit.dart' as _i49;
import 'package:dappstore/core/localisation/store/i_localisation_store.dart'
    as _i20;
import 'package:dappstore/core/localisation/store/localisation_store.dart'
    as _i21;
import 'package:dappstore/core/permissions/i_permissions_cubit.dart' as _i22;
import 'package:dappstore/core/permissions/permissions_cubit.dart' as _i23;
import 'package:dappstore/core/platform_channel/i_platform_channel_cubit.dart'
    as _i24;
import 'package:dappstore/core/platform_channel/platform_channel_cubit.dart'
    as _i25;
import 'package:dappstore/core/router/custom_route_observer.dart' as _i3;
import 'package:dappstore/core/theme/i_theme_cubit.dart' as _i56;
import 'package:dappstore/core/theme/store/i_theme_store.dart' as _i38;
import 'package:dappstore/core/theme/store/theme_store.dart' as _i39;
import 'package:dappstore/core/theme/theme_cubit.dart' as _i57;
import 'package:dappstore/features/dapp_info/application/dapp_info_cubit.dart'
    as _i43;
import 'package:dappstore/features/dapp_info/application/handler/dapp_title_tile_handler.dart'
    as _i11;
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_title_tile_handler.dart'
    as _i10;
import 'package:dappstore/features/dapp_info/application/i_dapp_info_cubit.dart'
    as _i42;
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart'
    as _i36;
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart'
    as _i37;
import 'package:dappstore/features/dapp_store_home/domain/repositories/i_dapp_list_repository.dart'
    as _i8;
import 'package:dappstore/features/dapp_store_home/infrastructure/repositories/dapp_list_repository_impl.dart'
    as _i9;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/downloader/downloader_cubit.dart'
    as _i45;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/downloader/i_downloader_cubit.dart'
    as _i44;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/foreground_service/foreground_service_cubit.dart'
    as _i47;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/foreground_service/i_foreground_service_cubit.dart'
    as _i46;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/installer/i_installer_cubit.dart'
    as _i18;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/installer/installer_cubit.dart'
    as _i19;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart'
    as _i50;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/package_manager_cubit.dart'
    as _i51;
import 'package:dappstore/features/pwa_webwiew/application/handler/i_pwa_webview_handler.dart'
    as _i28;
import 'package:dappstore/features/pwa_webwiew/application/handler/pwa_webview_handler.dart'
    as _i29;
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/i_injected_web3_cubit.dart'
    as _i60;
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit.dart'
    as _i61;
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/i_pwa_webview_cubit.dart'
    as _i26;
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit.dart'
    as _i27;
import 'package:dappstore/features/saved_dapps/application/handler/i_saved_dapps_handler.dart'
    as _i30;
import 'package:dappstore/features/saved_dapps/application/handler/saved_dapps_handler.dart'
    as _i31;
import 'package:dappstore/features/saved_dapps/application/i_saved_dapps_cubit.dart'
    as _i52;
import 'package:dappstore/features/saved_dapps/application/saved_dapps_cubit.dart'
    as _i53;
import 'package:dappstore/features/saved_pwa/application/handler/i_saved_pwa_page_handler.dart'
    as _i32;
import 'package:dappstore/features/saved_pwa/application/handler/saved_pwa_page_handler.dart'
    as _i33;
import 'package:dappstore/features/saved_pwa/application/i_saved_pwa_cubit.dart'
    as _i54;
import 'package:dappstore/features/saved_pwa/application/saved_pwa_cubit.dart'
    as _i55;
import 'package:dappstore/features/saved_pwa/infrastructure/store/i_saved_pwa_store.dart'
    as _i34;
import 'package:dappstore/features/saved_pwa/infrastructure/store/saved_pwa_store.dart'
    as _i35;
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart'
    as _i58;
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/wallet_connect_cubit.dart'
    as _i59;
import 'package:dappstore/features/wallet_connect/infrastructure/store/i_wallet_connect_store.dart'
    as _i40;
import 'package:dappstore/features/wallet_connect/infrastructure/store/wallet_connect_store.dart'
    as _i41;
import 'package:dappstore/widgets/buttons/app_button_handler/app_button_handler.dart'
    as _i5;
import 'package:dappstore/widgets/buttons/app_button_handler/i_app_button_handler.dart'
    as _i4;
import 'package:dappstore/widgets/installed_dapps_tiles/i_installed_dapps_tile_handler.dart'
    as _i16;
import 'package:dappstore/widgets/installed_dapps_tiles/installed_dapps_tile_handler.dart'
    as _i17;
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
  gh.lazySingleton<_i10.IDappTitleTileHandler>(
      () => _i11.DappTitleTileHandler());
  gh.lazySingleton<_i12.IErrorLogger>(() => _i13.ErrorLogger());
  gh.lazySingleton<_i14.IInstalledAppsCubit>(() => _i15.InstalledAppsCubit());
  gh.lazySingleton<_i16.IInstalledDappsTileHandler>(
      () => _i17.InstalledDappsTileHandler());
  gh.lazySingleton<_i18.IInstallerCubit>(() => _i19.InstallerCubit());
  gh.lazySingleton<_i20.ILocalisationStore>(() => _i21.LocalisationStore());
  gh.lazySingleton<_i22.IPermissions>(() => _i23.Permissions());
  gh.lazySingleton<_i24.IPlatformChannelCubit>(
      () => _i25.PlatformChannelCubit());
  gh.lazySingleton<_i26.IPwaWebviewCubit>(() => _i27.PwaWebviewCubit());
  gh.lazySingleton<_i28.IPwaWebviewHandler>(() => _i29.PwaWebviewHandler());
  gh.lazySingleton<_i30.ISavedDappsHandler>(() => _i31.SavedDappsHandler());
  gh.lazySingleton<_i32.ISavedPwaPageHandler>(() => _i33.SavedPwaPageHandler());
  gh.lazySingleton<_i34.ISavedPwaStore>(
      () => _i35.SavedPwaStore(errorLogger: gh<_i12.IErrorLogger>()));
  gh.lazySingleton<_i36.IStoreCubit>(
      () => _i37.StoreCubit(dappListRepo: gh<_i8.IDappListRepo>()));
  gh.lazySingleton<_i38.IThemeStore>(() => _i39.ThemeStore());
  gh.lazySingleton<_i40.IWalletConnectStore>(
      () => _i41.WalletConnectStore(errorLogger: gh<_i12.IErrorLogger>()));
  gh.lazySingleton<_i42.IDappInfoCubit>(
      () => _i43.DappInfoCubit(storeCubit: gh<_i36.IStoreCubit>()));
  gh.lazySingleton<_i44.IDownloader>(() => _i45.DownloaderCubit(
        permissionsCubit: gh<_i22.IPermissions>(),
        installerCubit: gh<_i18.IInstallerCubit>(),
      ));
  gh.lazySingleton<_i46.IForegroundService>(() => _i47.ForegroundService(
      platformChannelCubit: gh<_i24.IPlatformChannelCubit>()));
  gh.lazySingleton<_i48.ILocaleCubit>(
      () => _i49.LocaleCubit(localisationStore: gh<_i20.ILocalisationStore>()));
  gh.lazySingleton<_i50.IPackageManager>(() => _i51.PackageManager(
        gh<_i18.IInstallerCubit>(),
        gh<_i44.IDownloader>(),
        gh<_i46.IForegroundService>(),
        gh<_i14.IInstalledAppsCubit>(),
      ));
  gh.lazySingleton<_i52.ISavedDappsCubit>(() => _i53.SavedDappsCubit(
        packageManager: gh<_i50.IPackageManager>(),
        storeCubit: gh<_i36.IStoreCubit>(),
      ));
  gh.lazySingleton<_i54.ISavedPwaCubit>(
      () => _i55.SavedPwaCubit(savedPwaStore: gh<_i34.ISavedPwaStore>()));
  gh.lazySingleton<_i56.IThemeCubit>(
      () => _i57.ThemeCubit(themeStore: gh<_i38.IThemeStore>()));
  gh.lazySingleton<_i58.IWalletConnectCubit>(() => _i59.WalletConnectCubit(
        errorLogger: gh<_i12.IErrorLogger>(),
        wcStore: gh<_i40.IWalletConnectStore>(),
      ));
  gh.lazySingleton<_i60.IInjectedWeb3Cubit>(() => _i61.InjectedWeb3Cubit(
        signer: gh<_i58.IWalletConnectCubit>(),
        errorLogger: gh<_i12.IErrorLogger>(),
      ));
  return getIt;
}
