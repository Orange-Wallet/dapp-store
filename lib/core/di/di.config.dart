// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dappstore/core/installed_apps/i_installed_apps_cubit.dart'
    as _i7;
import 'package:dappstore/core/installed_apps/installed_apps_cubit.dart' as _i8;
import 'package:dappstore/core/permissions/i_permissions_cubit.dart' as _i9;
import 'package:dappstore/core/permissions/permissions_cubit.dart' as _i10;
import 'package:dappstore/core/platform_channel/i_platform_channel_cubit.dart'
    as _i11;
import 'package:dappstore/core/platform_channel/platform_channel_cubit.dart'
    as _i12;
import 'package:dappstore/core/theme/i_theme_cubit.dart' as _i17;
import 'package:dappstore/core/theme/theme_cubit.dart' as _i18;
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart'
    as _i15;
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart'
    as _i16;
import 'package:dappstore/features/dapp_store_home/domain/repositories/i_dapp_list_repository.dart'
    as _i3;
import 'package:dappstore/features/dapp_store_home/infrastructure/repositories/dapp_list_repository_impl.dart'
    as _i4;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/downloader/downloader_cubit.dart'
    as _i22;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/downloader/i_downloader_cubit.dart'
    as _i21;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/foreground_service/foreground_service_cubit.dart'
    as _i24;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/foreground_service/i_foreground_service_cubit.dart'
    as _i23;
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/i_injected_web3_cubit.dart'
    as _i5;
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit.dart'
    as _i6;
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/i_pwa_webview_cubit.dart'
    as _i13;
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit.dart'
    as _i14;
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/wallet_connect_cubit.dart'
    as _i20;
import 'package:dappstore/features/wallet_connect/infrastructure/wallet_connect.dart'
    as _i19;
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
  gh.lazySingleton<_i3.IDappListRepo>(() => _i4.DappListRepoImpl());
  gh.lazySingleton<_i5.IInjectedWeb3Cubit>(() => _i6.InjectedWeb3Cubit());
  gh.lazySingleton<_i7.IInstalledAppsCubit>(() => _i8.InstalledAppsCubit());
  gh.lazySingleton<_i9.IPermissions>(() => _i10.Permissions());
  gh.lazySingleton<_i11.IPlatformChannelCubit>(
      () => _i12.PlatformChannelCubit());
  gh.lazySingleton<_i13.IPwaWebviewCubit>(() => _i14.PwaWebviewCubit());
  gh.lazySingleton<_i15.IStoreCubit>(
      () => _i16.StoreCubit(dappListRepo: gh<_i3.IDappListRepo>()));
  gh.lazySingleton<_i17.IThemeCubit>(() => _i18.ThemeCubit());
  gh.lazySingleton<_i19.WalletConnect>(() => _i19.WalletConnect());
  gh.lazySingleton<_i20.WalletConnectCubit>(() => _i20.WalletConnectCubit());
  gh.lazySingleton<_i21.IDownloader>(
      () => _i22.DownloaderCubit(permissionsCubit: gh<_i9.IPermissions>()));
  gh.lazySingleton<_i23.IForegroundService>(() => _i24.ForegroundService(
      platformChannelCubit: gh<_i11.IPlatformChannelCubit>()));
  return getIt;
}
