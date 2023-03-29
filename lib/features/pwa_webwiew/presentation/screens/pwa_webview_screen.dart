import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/router/interface/route.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/in_screen_appbar.dart';
import 'package:dappstore/features/pwa_webwiew/application/handler/i_pwa_webview_handler.dart';
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/i_injected_web3_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/i_pwa_webview_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/presentation/widgets/pwa_webview_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_injected_web3/flutter_injected_web3.dart';

class PwaWebView extends StatefulScreen {
  final String dappName;
  const PwaWebView({super.key, required this.dappName});

  @override
  State<PwaWebView> createState() => _PwaWebViewState();

  @override
  String get route => "/pwaWebview";
}

class _PwaWebViewState extends State<PwaWebView> {
  late IPwaWebviewHandler handler;
  late IPwaWebviewCubit pwaWebviewCubit;
  late IInjectedWeb3Cubit injectedWeb3Cubit;
  late IThemeCubit themeCubit;
  late String _dappName;

  @override
  void initState() {
    handler = getIt<IPwaWebviewHandler>();
    pwaWebviewCubit = handler.webViewCubit;
    injectedWeb3Cubit = handler.injectedWeb3Cubit;
    handler.initInjectedWeb3(context);
    themeCubit = handler.themeCubit;
    _dappName = widget.dappName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IPwaWebviewCubit, PwaWebviewState>(
      bloc: pwaWebviewCubit,
      builder: (context, webViewState) {
        return BlocBuilder<IInjectedWeb3Cubit, InjectedWeb3State>(
          bloc: injectedWeb3Cubit,
          builder: (context, injectedWeb3State) {
            return GestureDetector(
              onTap: handler.unfocus,
              child: Scaffold(
                appBar: PwaAppBar(
                  theme: themeCubit.theme,
                  title: _dappName,
                  backwards: handler.onBackPressed,
                  forward: handler.onForwardPressed,
                  progress: webViewState.progress,
                ),
                body: Stack(
                  children: [
                    InjectedWebview(
                      isDebug: true,
                      initialUrlRequest:
                          URLRequest(url: Uri.parse(webViewState.url)),
                      chainId: injectedWeb3State.connectedChainId ?? 1,
                      rpc: injectedWeb3State.connectedChainRpc ??
                          "https://rpc.ankr.com/polygon",
                      onWebViewCreated: handler.initWebViewCubit,
                      initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                          useShouldOverrideUrlLoading: true,
                        ),
                        android: AndroidInAppWebViewOptions(
                            useHybridComposition: true),
                      ),
                      onProgressChanged: handler.onProgressChanged,
                      onLoadStart: handler.onLoadStart,
                      onLoadStop: handler.onLoadStop,
                      signMessage: handler.signMessage,
                      requestAccounts: handler.requestAccount,
                      signTransaction: handler.signTransaction,
                      signTypedMessage: handler.signTypedMessage,
                      signPersonalMessage: handler.signPersonalMessage,
                      addEthereumChain: handler.addEthereumChain,
                      watchAsset: handler.watchAsset,
                      ecRecover: handler.ecRecover,
                      shouldOverrideUrlLoading:
                          handler.shouldOverrideUrlLoading,
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
