import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/features/dapp_info/presentation/screens/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/widgets/installed_dapps_tiles/i_installed_dapps_tile_handler.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IInstalledDappsTileHandler)
class InstalledDappsTileHandler implements IInstalledDappsTileHandler {
  @override
  IPackageManager get packageManager => getIt<IPackageManager>();
  @override
  IStoreCubit get storeCubit => getIt<IStoreCubit>();

  @override
  updateDapp(DappInfo dappInfo) async {
    final url = await storeCubit.getBuildUrl(dappInfo.dappId!);
    packageManager.startDownload(dappInfo, url, true);
  }

  @override
  openDapp(BuildContext context, String dappId) {
    storeCubit.setActiveDappId(dappId: dappId);
    context.pushRoute(const DappInfoPage());
  }
}
