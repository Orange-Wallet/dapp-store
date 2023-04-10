import 'package:dappstore/core/application/init/store.dart';
import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/core/localisation/i_localisation_cubit.dart';
import 'package:dappstore/core/store/i_cache_store.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/downloader/i_downloader_cubit.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/saved_dapps/application/i_saved_dapps_cubit.dart';
import 'package:dappstore/features/saved_pwa/application/i_saved_pwa_cubit.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';

Future<void> initialise() async {
  configureDependencies();
  await getIt<IDownloader>().initialize();
  await getIt<IErrorLogger>().initialise();
  await initialiseStore().then((_) {
    getIt<IThemeCubit>().initialise(height: 844, width: 360);
    getIt<ILocaleCubit>().initialise();
    getIt<ISavedPwaCubit>().initialise();
    getIt<ICacheStore>().initialise();
  });

  // WC initialise
  await getIt<IWalletConnectCubit>().initialize();
  await getIt<IWalletConnectCubit>().getPreviouslyConnectedSession();

  await getIt<IPackageManager>().init();

  // await getIt<IPermissions>().requestNotificationPermission();
  // await getIt<IPermissions>().requestStoragePermission();
  // await getIt<IPermissions>().requestAppInstallationPermission();
  await getIt<IDownloader>().initializeStorageDir();
  await getIt<ISavedDappsCubit>().initialise();
}
