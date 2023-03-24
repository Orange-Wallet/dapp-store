import 'package:dappstore/core/application/init/store.dart';
import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/core/localisation/i_localisation_cubit.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';

Future<void> initialise() async {
  configureDependencies();
  //await getIt<IDownloader>().initialize();
  await getIt<IErrorLogger>().initialise();
  await initialiseStore().then((_) {
    getIt<IThemeCubit>().initialise();
    getIt<ILocaleCubit>().initialise();
  });
  // await getIt<WalletConnectCubit>().initialize();
  // Initialize the app dependencies
}
