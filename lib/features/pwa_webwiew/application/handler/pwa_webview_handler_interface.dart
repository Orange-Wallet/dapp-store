import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit_interface.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_injected_web3/flutter_injected_web3.dart';

abstract class IPwaWebviewHandler {
  IPwaWebviewCubit getWebViewCubit();
  IInjectedWeb3Cubit getInjectedWebViewCubit();
  void unfocus();
  void onBackPressed();
  void initWebViewCubit(InAppWebViewController controller);
  void clearCookies();
  void onLoadStop(InAppWebViewController controller, Uri? uri) {
    debugPrint('onLoadStop $uri');
    loadStop();
  }

  void loadStop() {
    getWebViewCubit().setLoading(false);
    getWebViewCubit().updateButtonsState();
  }

  void onProgressChanged(InAppWebViewController controller, int progress);

  void onLoadStart(InAppWebViewController controller, Uri? uri);

  Future<String> signMessage(
      InAppWebViewController controller, String data, int chainId);

  Future<IncomingAccountsModel> requestAccount(
      InAppWebViewController controller, String data, int chainId);

  Future<String> signTransaction(
      InAppWebViewController controller, JsTransactionObject data, int chainId);

  Future<String> signTypedMessage(
      InAppWebViewController controller, JsEthSignTypedData data, int chainId);

  Future<String> signPersonalMessage(
      InAppWebViewController controller, String data, int chainId);

  Future<String> addEthereumChain(
      InAppWebViewController controller, JsAddEthereumChain data, int chainId);

  Future<String> watchAsset(
      InAppWebViewController controller, JsWatchAsset data, int chainId);

  Future<String> ecRecover(
      InAppWebViewController controller, JsEcRecoverObject data, int chainId);

  Future<NavigationActionPolicy> shouldOverrideUrlLoading(
      InAppWebViewController controller, NavigationAction action);
}
