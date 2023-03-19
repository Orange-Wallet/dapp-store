import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit_interface.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit_interface.dart';
import 'package:dappstore/features/pwa_webwiew/application/screens/pwa_webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<IPwaWebviewCubit>(create: (_) => PwaWebviewCubit()),
        BlocProvider<IInjectedWeb3Cubit>(create: (_) => InjectedWeb3Cubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PwaWebView(
          dappName: "DappRadar",
        ),
      ),
    );
  }
}
