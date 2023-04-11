import 'package:dappstore/config/config.dart';
import 'package:dappstore/core/application/app.dart';
import 'package:dappstore/core/application/init/init.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialise();
  // await SentryFlutter.init(
  //   (options) {
  //     options.dsn = Config.sentryDSN;
  //     // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
  //     // We recommend adjusting this value in production
  //     options.sendDefaultPii = false;
  //     options.tracesSampleRate = 1.0;
  //   },
  //   appRunner: () => runApp(const App()),
  // );
  runApp(const App());
}
