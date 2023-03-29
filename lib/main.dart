import 'package:dappstore/core/application/app.dart';
import 'package:dappstore/core/application/init/init.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialise();
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://6b758247cdb149a1950fd476f793df98@o4504921352372224.ingest.sentry.io/4504921353486336';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production
      options.sendDefaultPii = false;
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const App()),
  );
}
