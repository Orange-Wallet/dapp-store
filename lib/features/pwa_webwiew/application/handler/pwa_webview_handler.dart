import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/features/pwa_webwiew/application/handler/pwa_webview_handler_interface.dart';
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit_interface.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit_interface.dart';

class PwaWebviewHandler implements IPwaWebviewHandler {
  @override
  IPwaWebviewCubit getWebViewCubit() {
    return getIt<PwaWebviewCubit>();
  }

  @override
  IInjectedWeb3Cubit getInjectedWebViewCubit() {
    return getIt<InjectedWeb3Cubit>();
  }
}
