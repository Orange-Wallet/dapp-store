import 'package:dappstore/features/pwa_webwiew/application/handler/pwa_webview_handler.dart';
import 'package:dappstore/features/pwa_webwiew/application/handler/pwa_webview_handler_interface.dart';
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit_interface.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_injected_web3/flutter_injected_web3.dart';

class PwaWebView extends StatefulWidget {
  final String dappName;
  const PwaWebView({super.key, required this.dappName});

  @override
  State<PwaWebView> createState() => _PwaWebViewState();
}

class _PwaWebViewState extends State<PwaWebView> {
  late IPwaWebviewHandler handler;
  late IPwaWebviewCubit pwaWebviewCubit;
  late IInjectedWeb3Cubit injectedWeb3Cubit;
  late String _dappName;
  late AppBar appBar;

  @override
  void initState() {
    handler = PwaWebviewHandler();
    pwaWebviewCubit = handler.getWebViewCubit();
    injectedWeb3Cubit = handler.getInjectedWebViewCubit();
    _dappName = widget.dappName;
    appBar = AppBar(
      actions: [
        BackButton(onPressed: handler.onBackPressed),
        ElevatedButton(
            onPressed: handler.clearCookies, child: const Text("C C"))
      ],
      title: Text(_dappName),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IPwaWebviewCubit, PwaWebviewState>(
      bloc: pwaWebviewCubit,
      builder: (context, webViewState) {
        return BlocBuilder<IInjectedWeb3Cubit, InjectedWeb3State>(
          builder: (context, injectedWeb3State) {
            return GestureDetector(
              onTap: handler.unfocus,
              child: Scaffold(
                appBar: appBar,
                body: Stack(
                  children: [
                    InjectedWebview(
                      initialUrlRequest:
                          URLRequest(url: Uri.parse(webViewState.url)),
                      chainId: injectedWeb3State.connectedChainId ?? 1,
                      rpc: injectedWeb3State.connectedChainRpc ?? "",
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
