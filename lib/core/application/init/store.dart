import 'package:dappstore/core/theme/store/entities/theme_storage.dart';
import 'package:hive/hive.dart';

Future<void> initialiseStore() async {
  Hive.init("DappStore");
  //Register all the adapters here.
  Hive.registerAdapter(ThemeStorageAdapter());
}
