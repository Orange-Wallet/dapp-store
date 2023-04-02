import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/package_manager_cubit.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:dappstore/widgets/installed_dapps_tiles/i_installed_dapps_tile_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class InstalledDappsTile extends StatelessWidget {
  final DappInfo dappInfo;
  final IThemeSpec theme;

  const InstalledDappsTile({
    Key? key,
    required this.dappInfo,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IInstalledDappsTileHandler handler = getIt<IInstalledDappsTileHandler>();
    final leading = SizedBox(
      height: 42,
      width: 42,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: ImageWidgetCached(
          dappInfo.images?.logo! ?? "",
          fit: BoxFit.fill,
          height: 42,
          width: 42,
        ),
      ),
    );
    final title = Text(
      dappInfo.name!,
      style: theme.titleTextStyle,
    );
    final subtitle = Text(
      "${dappInfo.developer} · ${dappInfo.category}",
      style: theme.bodyTextStyle,
    );
    final updateButton = TextButton(
      onPressed: () async {
        //todo: trigger ui update
        handler.updateDapp(dappInfo);
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: theme.appGreen,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: theme.appGreen,
          ),
          borderRadius: BorderRadius.circular(36),
        ),
      ),
      child: SizedBox(
        width: 80,
        height: 28,
        child: Center(
          child: Text(
            context.getLocale!.update,
            style: theme.whiteBodyTextStyle,
          ),
        ),
      ),
    );
    final openButton = TextButton(
      onPressed: () {
        handler.openDapp(
          context,
          dappInfo.dappId!,
        );
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: theme.appGreen,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: theme.appGreen,
          ),
          borderRadius: BorderRadius.circular(36),
        ),
      ),
      child: SizedBox(
        width: 73,
        height: 28,
        child: Text(
          context.getLocale!.update,
          style: theme.bodyTextStyle,
        ),
      ),
    );
    final greyInstallingButton = Center(
      child: TextButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: theme.greyBlue,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: theme.appGreen,
            ),
            borderRadius: BorderRadius.circular(36),
          ),
        ),
        child: SizedBox(
          width: 73,
          height: 28,
          child: Text(
            context.getLocale!.installing,
            style: theme.greyHeading,
          ),
        ),
      ),
    );
    final circularProgressIndicator = CircularProgressIndicator.adaptive(
      backgroundColor: theme.greyBlue,
      valueColor: AlwaysStoppedAnimation<Color>(theme.blue),
    );

    return BlocBuilder<IPackageManager, PackageManagerState>(
      bloc: handler.packageManager,
      builder: (context, packageManagerState) {
        final packageMapping = packageManagerState.packageMapping;
        final package = packageMapping![dappInfo.packageId];

        if (packageMapping[dappInfo.dappId]?.installing ?? false) {
          return SizedBox(
            height: 50,
            child: ListTile(
              leading: leading,
              title: title,
              subtitle: subtitle,
              trailing: greyInstallingButton,
            ),
          );
        } else if ((package?.status == DownloadTaskStatus.enqueued ||
                package?.status == DownloadTaskStatus.running) &&
            (package?.progress != null && package?.progress != 100)) {
          return SizedBox(
            height: 50,
            child: ListTile(
              leading: leading,
              title: title,
              subtitle: subtitle,
              trailing: circularProgressIndicator,
            ),
          );
        } else if (((double.tryParse(dappInfo.version ?? "0") ?? 0) >
            (package?.versionCode ?? 0))) {
          return SizedBox(
            height: 50,
            child: ListTile(
              leading: leading,
              title: title,
              subtitle: subtitle,
              trailing: updateButton,
            ),
          );
        } else {
          return SizedBox(
            height: 50,
            child: ListTile(
              leading: leading,
              title: title,
              subtitle: subtitle,
              trailing: openButton,
            ),
          );
        }
      },
    );
  }
}
