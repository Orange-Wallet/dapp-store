import 'package:dappstore/core/application/init/store.dart';
import 'package:dappstore/core/di/di.dart';

Future<void> initialise() async {
  configureDependencies();

  await initialiseStore();
  // Initialize the app dependencies
}
