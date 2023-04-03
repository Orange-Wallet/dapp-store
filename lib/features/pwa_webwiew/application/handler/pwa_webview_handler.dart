import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/handler/i_pwa_webview_handler.dart';
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/i_injected_web3_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/i_pwa_webview_cubit.dart';
import 'package:dappstore/widgets/snacbar/snacbar_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_injected_web3/flutter_injected_web3.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IPwaWebviewHandler)
class PwaWebviewHandler implements IPwaWebviewHandler {
  @override
  IPwaWebviewCubit get webViewCubit => getIt<IPwaWebviewCubit>();

  @override
  IInjectedWeb3Cubit get injectedWeb3Cubit => getIt<IInjectedWeb3Cubit>();

  @override
  IThemeCubit get themeCubit => getIt<IThemeCubit>();

  @override
  void unfocus() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    webViewCubit.hideUrlField();
  }

  @override
  void onBackPressed() async {
    debugPrint("On Back pressed");
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    if ((await webViewCubit.webViewController?.canGoBack()) ?? false) {
      webViewCubit.webViewController?.goBack();
    }
  }

  @override
  void onForwardPressed() async {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    if ((await webViewCubit.webViewController?.canGoForward()) ?? false) {
      webViewCubit.webViewController?.goForward();
    }
  }

  @override
  void initWebViewCubit(InAppWebViewController controller) {
    webViewCubit.initWebViewController(controller);
  }

  @override
  initInjectedWeb3(BuildContext context) {
    injectedWeb3Cubit.started((SigningFailures error) {
      String errorString;
      switch (error) {
        case SigningFailures.SIGNING_FAILED:
          {
            errorString = context.getLocale!.signingFailed;
            break;
          }
        case SigningFailures.METHOD_NOT_SUPPORTED:
          {
            errorString = context.getLocale!.methodNotSupported;
            break;
          }
        case SigningFailures.SENDING_FAILED:
          {
            errorString = context.getLocale!.sendingTxFail;
            break;
          }
        case SigningFailures.CHAIN_NOT_SUPPORTED:
          {
            errorString = context.getLocale!.sendingTxFail;
            break;
          }
      }
      context.showMsgBar(errorString);
    });
  }

  @override
  void clearCookies() {
    webViewCubit.webViewController?.clearCache();
  }

  @override
  void onProgressChanged(InAppWebViewController controller, int progress) {
    debugPrint('PROGRESS $progress');
    webViewCubit.updateProgress(progress);
  }

  @override
  void onLoadStart(InAppWebViewController controller, Uri? uri) {
    debugPrint('onLoadStart $uri');
    webViewCubit.setLoading(true);
    webViewCubit.updateButtonsState(loadStart: true);
  }

  @override
  void onLoadStop(InAppWebViewController controller, Uri? uri) {
    debugPrint('onLoadStop $uri');
    loadStop();
  }

  @override
  void loadStop() {
    webViewCubit.setLoading(false);
    webViewCubit.updateButtonsState();
  }

  @override
  Future<String> signMessage(
      InAppWebViewController controller, String data, int chainId) async {
    return "";
  }

  @override
  Future<IncomingAccountsModel> requestAccount(
      InAppWebViewController controller, String data, chainId) async {
    return IncomingAccountsModel(
      address: injectedWeb3Cubit.account,
      chainId: int.tryParse(injectedWeb3Cubit.chainId!),
      rpcUrl: "",
    );
  }

  @override
  Future<String> signTransaction(InAppWebViewController controller,
      JsTransactionObject data, chainId) async {
    debugPrint("tx callback ${data.toString()}");
    return injectedWeb3Cubit.sendTransaction(data, () {});
  }

  @override
  Future<String> signTypedMessage(InAppWebViewController controller,
      JsEthSignTypedData data, chainId) async {
    return injectedWeb3Cubit.signTypedData(data, () {});
  }

  @override
  Future<String> signPersonalMessage(
      InAppWebViewController controller, data, chainId) async {
    return injectedWeb3Cubit.signPersonalMessage(data, () {});
  }

  @override
  Future<String> addEthereumChain(InAppWebViewController controller,
      JsAddEthereumChain data, chainId) async {
    return injectedWeb3Cubit
        .changeChains(int.tryParse(data.chainId ?? "1") ?? 1);
  }

  @override
  Future<String> watchAsset(
      InAppWebViewController controller, JsWatchAsset data, chainId) async {
    return "";
  }

  @override
  Future<String> ecRecover(InAppWebViewController controller,
      JsEcRecoverObject data, chainId) async {
    return "";
  }

  @override
  Future<NavigationActionPolicy> shouldOverrideUrlLoading(
      InAppWebViewController controller,
      NavigationAction navigationAction) async {
    final navUrl = webViewCubit.webViewController?.getUrl().toString();
    debugPrint('Browser URL: $navUrl');
    if (navUrl == "") {
      return NavigationActionPolicy.ALLOW;
    } else {
      return NavigationActionPolicy.ALLOW;
    }
  }
}
