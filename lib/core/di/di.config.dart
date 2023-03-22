// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dappstore/core/application/app_handler.dart' as _i5;
import 'package:dappstore/core/application/i_app_handler.dart' as _i4;
import 'package:dappstore/core/installed_apps/i_installed_apps_cubit.dart'
    as _i10;
import 'package:dappstore/core/installed_apps/installed_apps_cubit.dart'
    as _i11;
import 'package:dappstore/core/permissions/i_permissions_cubit.dart' as _i12;
import 'package:dappstore/core/permissions/permissions_cubit.dart' as _i13;
import 'package:dappstore/core/platform_channel/i_platform_channel_cubit.dart'
    as _i14;
import 'package:dappstore/core/platform_channel/platform_channel_cubit.dart'
    as _i15;
import 'package:dappstore/core/router/custom_route_observer.dart' as _i3;
import 'package:dappstore/core/theme/i_theme_cubit.dart' as _i30;
import 'package:dappstore/core/theme/store/i_theme_store.dart' as _i22;
import 'package:dappstore/core/theme/store/theme_store.dart' as _i23;
import 'package:dappstore/core/theme/theme_cubit.dart' as _i31;
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart'
    as _i20;
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart'
    as _i21;
import 'package:dappstore/features/dapp_store_home/domain/repositories/i_dapp_list_repository.dart'
    as _i6;
import 'package:dappstore/features/dapp_store_home/infrastructure/repositories/dapp_list_repository_impl.dart'
    as _i7;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/downloader/downloader_cubit.dart'
    as _i27;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/downloader/i_downloader_cubit.dart'
    as _i26;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/foreground_service/foreground_service_cubit.dart'
    as _i29;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/foreground_service/i_foreground_service_cubit.dart'
    as _i28;
import 'package:dappstore/features/pwa_webwiew/application/handler/i_pwa_webview_handler.dart'
    as _i18;
import 'package:dappstore/features/pwa_webwiew/application/handler/pwa_webview_handler.dart'
    as _i19;
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/i_injected_web3_cubit.dart'
    as _i8;
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit.dart'
    as _i9;
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/i_pwa_webview_cubit.dart'
    as _i16;
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit.dart'
    as _i17;
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/wallet_connect_cubit.dart'
    as _i25;
import 'package:dappstore/features/wallet_connect/infrastructure/wallet_connect.dart'
    as _i24;
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
  gh.lazySingleton<_i4.IAppHandler>(() => _i5.AppHandler());
  gh.lazySingleton<_i6.IDappListRepo>(() => _i7.DappListRepoImpl());
  gh.lazySingleton<_i8.IInjectedWeb3Cubit>(() => _i9.InjectedWeb3Cubit());
  gh.lazySingleton<_i10.IInstalledAppsCubit>(() => _i11.InstalledAppsCubit());
  gh.lazySingleton<_i12.IPermissions>(() => _i13.Permissions());
  gh.lazySingleton<_i14.IPlatformChannelCubit>(
      () => _i15.PlatformChannelCubit());
  gh.lazySingleton<_i16.IPwaWebviewCubit>(() => _i17.PwaWebviewCubit());
  gh.lazySingleton<_i18.IPwaWebviewHandler>(() => _i19.PwaWebviewHandler());
  gh.lazySingleton<_i20.IStoreCubit>(
      () => _i21.StoreCubit(dappListRepo: gh<_i6.IDappListRepo>()));
  gh.lazySingleton<_i22.IThemeStore>(() => _i23.ThemeStore());
  gh.lazySingleton<_i24.WalletConnect>(() => _i24.WalletConnect());
  gh.lazySingleton<_i25.WalletConnectCubit>(() => _i25.WalletConnectCubit());
  gh.lazySingleton<_i26.IDownloader>(
      () => _i27.DownloaderCubit(permissionsCubit: gh<_i12.IPermissions>()));
  gh.lazySingleton<_i28.IForegroundService>(() => _i29.ForegroundService(
      platformChannelCubit: gh<_i14.IPlatformChannelCubit>()));
  gh.lazySingleton<_i30.IThemeCubit>(
      () => _i31.ThemeCubit(themeStore: gh<_i22.IThemeStore>()));
  return getIt;
}
