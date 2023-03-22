import 'package:dappstore/core/application/i_app_handler.dart';
import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/test_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  late IAppHandler appHandler;
  @override
  void initState() {
    appHandler = getIt<IAppHandler>();
    WidgetsBinding.instance.addObserver(this);
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    if (brightness == Brightness.dark &&
        appHandler.isFollowingSystemBrightness) {
      appHandler.setDarkTheme();
      debugPrint("Switching to dark theme");
    } else if (brightness == Brightness.light &&
        appHandler.isFollowingSystemBrightness) {
      appHandler.setLightTheme();
      debugPrint("Switching to Light theme");
    }
    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    if (brightness == Brightness.dark &&
        appHandler.isFollowingSystemBrightness) {
      appHandler.setDarkTheme();
      debugPrint("Switching to dark theme");
    } else if (brightness == Brightness.light &&
        appHandler.isFollowingSystemBrightness) {
      appHandler.setLightTheme();
      debugPrint("Switching to Light theme");
    }
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.black,
        useMaterial3: true,
      ),
      themeMode: appHandler.themeCubit.theme.isDarkTheme
          ? ThemeMode.dark
          : ThemeMode.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates.toList(),
      supportedLocales: AppLocalizations.supportedLocales,
      locale: appHandler.localeCubit.getLocaleToUse(),
      home: const TestHomePage(),
    );
  }
}
