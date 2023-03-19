import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/features/pwa_webwiew/application/handler/pwa_webview_handler_interface.dart';
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit_interface.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit_interface.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_injected_web3/flutter_injected_web3.dart';

class PwaWebviewHandler implements IPwaWebviewHandler {
  @override
  IPwaWebviewCubit getWebViewCubit() {
    return getIt<PwaWebviewCubit>();
  }

  @override
  IInjectedWeb3Cubit getInjectedWebViewCubit() {
    return getIt<InjectedWeb3Cubit>();
  }

  @override
  void unfocus() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    getWebViewCubit().hideUrlField();
  }

  @override
  void onBackPressed() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    getWebViewCubit().webViewController?.goBack();
  }

  @override
  void initWebViewCubit(InAppWebViewController controller) {
    getWebViewCubit().initWebViewController(controller);
  }

  @override
  void clearCookies() {
    getWebViewCubit().webViewController?.clearCache();
  }

  @override
  void onProgressChanged(InAppWebViewController controller, int progress) {
    debugPrint('PROGRESS $progress');
    getWebViewCubit().updateProgress(progress);
  }

  @override
  void onLoadStart(InAppWebViewController controller, Uri? uri) {
    debugPrint('onLoadStart $uri');
    getWebViewCubit().setLoading(true);
    getWebViewCubit().updateButtonsState(loadStart: true);
  }

  @override
  void onLoadStop(InAppWebViewController controller, Uri? uri) {
    debugPrint('onLoadStop $uri');
    loadStop();
  }

  @override
  void loadStop() {
    getWebViewCubit().setLoading(false);
    getWebViewCubit().updateButtonsState();
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
        address: "0x2Ee331840018465bD7Fe74aA4E442b9EA407fBBE",
        chainId: 1,
        rpcUrl: "");
  }

  @override
  Future<String> signTransaction(InAppWebViewController controller,
      JsTransactionObject data, chainId) async {
    return "";
  }

  @override
  Future<String> signTypedMessage(InAppWebViewController controller,
      JsEthSignTypedData data, chainId) async {
    return "";
  }

  @override
  Future<String> signPersonalMessage(
      InAppWebViewController controller, data, chainId) async {
    return "";
  }

  @override
  Future<String> addEthereumChain(InAppWebViewController controller,
      JsAddEthereumChain data, chainId) async {
    return "";
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
    final navUrl = getWebViewCubit().webViewController?.getUrl().toString();
    debugPrint('Browser URL: $navUrl');
    if (navUrl == "") {
      return NavigationActionPolicy.ALLOW;
    } else {
      return NavigationActionPolicy.ALLOW;
    }
  }
}
