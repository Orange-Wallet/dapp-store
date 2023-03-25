import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/i_pwa_webview_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/presentation/screens/pwa_webview_screen.dart';
import 'package:dappstore/widgets/snacbar/snacbar_context_extension.dart';
import 'package:flutter/material.dart';

class AppButtonHandler {
  IPackageManager get packageManager => getIt<IPackageManager>();
  IPwaWebviewCubit get pwaWebviewCubit => getIt<IPwaWebviewCubit>();
  IStoreCubit get storeCubit => getIt<IStoreCubit>();
  startDownload(DappInfo dappInfo, BuildContext context) async {
    final url = await storeCubit.getBuildUrl(dappInfo.dappId!);
    if (url != null) {
      await packageManager.startDownload(dappInfo, "link", true);
    } else {
      // ignore: use_build_context_synchronously
      context.showMsgBar(context.getLocale!.apkFetchFail);
    }
  }

  openPwaApp(BuildContext context, DappInfo dappInfo) async {
    pwaWebviewCubit.setUrl(dappInfo.appUrl!);
    context.pushRoute(PwaWebView(
      dappName: dappInfo.name!,
    ));
  }

  openApp(DappInfo dappInfo) async {
    await packageManager.openApp(dappInfo);
  }

  triggerInstall(DappInfo dappInfo) async {
    await packageManager.triggerInstall("${dappInfo.dappId}.apk");
  }
}
