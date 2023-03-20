import 'package:dappstore/core/application/init/store.dart';
import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/downloader/i_downloader_cubit.dart';

Future<void> initialise() async {
  configureDependencies();
  await getIt<IDownloader>().initialize();
  await initialiseStore();
  // Initialize the app dependencies
}
