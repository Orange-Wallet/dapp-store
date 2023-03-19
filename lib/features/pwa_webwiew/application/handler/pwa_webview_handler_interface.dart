import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit_interface.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit_interface.dart';

abstract class IPwaWebviewHandler {
  IPwaWebviewCubit getWebViewCubit();
  IInjectedWeb3Cubit getInjectedWebViewCubit();
}
