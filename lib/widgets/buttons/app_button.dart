import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/package_manager_cubit.dart';
import 'package:dappstore/widgets/buttons/app_button_handler/app_button_handler.dart';
import 'package:dappstore/widgets/buttons/elevated_button.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  final IThemeSpec theme;
  final DappInfo dappInfo;
  late AppButtonHandler appButtonHandler;
  late IPackageManager packageManager;
  final double radius;
  final double height;
  final double width;
  AppButton({
    Key? key,
    required this.theme,
    required this.dappInfo,
    required this.packageManager,
    required this.radius,
    required this.height,
    required this.width,
  }) : super(key: key) {
    appButtonHandler = getIt<AppButtonHandler>();
    packageManager = appButtonHandler.packageManager;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IPackageManager, PackageManagerState>(
      bloc: packageManager,
      buildWhen: (previous, current) {
        return previous.packageMapping![dappInfo.dappId!] !=
            current.packageMapping![dappInfo.dappId!];
      },
      builder: (context, state) {
        final packageInfo = state.packageMapping![dappInfo.dappId];
        if (packageInfo == null &&
            (dappInfo.availableOnPlatform?.contains("android") ?? false)) {
          return CustomElevatedButton(
            onTap: () {
              appButtonHandler.startDownload(dappInfo);
            },
            color: theme.appGreen,
            radius: radius,
            width: width,
            height: height,
            child: Text(
              context.getLocale!.download,
              style: theme.whiteBoldTextStyle,
            ),
          );
        } else if (!(dappInfo.availableOnPlatform?.contains("android") ??
            false)) {
          return CustomElevatedButton(
            onTap: () {
              appButtonHandler.openPwaApp(context, dappInfo);
            },
            color: theme.blue,
            radius: radius,
            width: width,
            height: height,
            child: Text(
              context.getLocale!.openDapp,
              style: theme.whiteBoldTextStyle,
            ),
          );
        } else if (packageInfo?.installed ?? false) {
          return CustomElevatedButton(
            onTap: () {
              appButtonHandler.openApp(dappInfo);
            },
            color: theme.blue,
            radius: radius,
            width: width,
            height: height,
            child: Text(
              context.getLocale!.openDapp,
              style: theme.whiteBoldTextStyle,
            ),
          );
        } else if (packageInfo?.status == DownloadTaskStatus.complete &&
            (packageInfo?.installing ?? false)) {
          return CustomElevatedButton(
            onTap: () {},
            color: theme.ratingGrey,
            radius: radius,
            width: width,
            height: height,
            child: Text(
              context.getLocale!.installing,
              style: theme.whiteBoldTextStyle,
            ),
          );
        } else if (packageInfo?.status == DownloadTaskStatus.complete &&
            (packageInfo?.installing ?? false) == false) {
          return CustomElevatedButton(
            onTap: () {
              appButtonHandler.triggerInstall(dappInfo);
            },
            color: theme.appGreen,
            radius: radius,
            width: width,
            height: height,
            child: Text(
              context.getLocale!.install,
              style: theme.whiteBoldTextStyle,
            ),
          );
        } else if ((packageInfo?.versionCode ?? 0) <
            (double.tryParse(dappInfo.version ?? "0") ?? 0)) {
          return CustomElevatedButton(
            onTap: () {
              appButtonHandler.startDownload(dappInfo);
            },
            color: theme.appGreen,
            radius: radius,
            width: width,
            height: height,
            child: Text(
              context.getLocale!.update,
              style: theme.whiteBoldTextStyle,
            ),
          );
        }
        return Container();
      },
    );
  }
}
