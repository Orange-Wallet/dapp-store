import 'package:dappstore/core/application/app_handler.dart';
import 'package:dappstore/core/application/i_app_handler.dart';
import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/dapp_store_home/presentation/pages/homepage.dart';
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/i_injected_web3_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/i_pwa_webview_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<IPwaWebviewCubit>(
            create: (_) => getIt<IPwaWebviewCubit>()),
        BlocProvider<IInjectedWeb3Cubit>(
            create: (_) => getIt<IInjectedWeb3Cubit>()),
        BlocProvider<IThemeCubit>(create: (_) => getIt<IThemeCubit>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        home: const HomePage(),
      ),
    );
  }
}
