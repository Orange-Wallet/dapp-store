import 'package:dappstore/core/localisation/store/entities/localisation_storage.dart';
import 'package:dappstore/core/theme/store/entities/theme_storage.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/entities/wallet_connect_store_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initialiseStore() async {
  await Hive.initFlutter("./dappstore");
  //Register all the adapters here.
  Hive.registerAdapter(ThemeStorageAdapter());
  Hive.registerAdapter(LocalisationStorageAdapter());
  Hive.registerAdapter(WalletConnectStoreModelAdapter());
}
