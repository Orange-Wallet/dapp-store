import 'package:dappstore/core/application/init/store.dart';
import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/core/localisation/i_localisation_cubit.dart';
import 'package:dappstore/core/permissions/i_permissions_cubit.dart';
import 'package:dappstore/core/store/i_cache_store.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/downloader/i_downloader_cubit.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/saved_dapps/application/i_saved_dapps_cubit.dart';
import 'package:dappstore/features/saved_pwa/application/i_saved_pwa_cubit.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';

Future<void> initialise() async {
  configureDependencies();
  getIt<IErrorLogger>().initialise();
  getIt<IDownloader>().initialize().then(
    (value) {
      getIt<IPackageManager>().init();
    },
  );

  initialiseStore().then((_) async {
    getIt<IThemeCubit>().initialise(height: 844, width: 360);
    getIt<ILocaleCubit>().initialise();
    getIt<ISavedPwaCubit>().initialise();
    getIt<ICacheStore>().initialise();

    // WC initialise
    await getIt<IWalletConnectCubit>().started();
  });
  await getIt<IPermissions>().requestStoragePermission().then((_) async {
    await getIt<IDownloader>().initializeStorageDir();
    await getIt<ISavedDappsCubit>().initialise();
  });
  // await getIt<IPermissions>().requestAppInstallationPermission();
}
