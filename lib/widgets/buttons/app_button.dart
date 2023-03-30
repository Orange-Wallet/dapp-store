import 'package:dappstore/features/saved_pwa/application/i_saved_pwa_cubit.dart';
import 'package:dappstore/features/saved_pwa/application/saved_pwa_cubit.dart';
import 'package:dappstore/widgets/buttons/app_button_handler/i_app_button_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/package_manager_cubit.dart';
import 'package:dappstore/widgets/buttons/elevated_button.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  final IThemeSpec theme;
  final DappInfo dappInfo;
  late IAppButtonHandler appButtonHandler;
  late IPackageManager packageManager;
  final double radius;
  final double height;
  final double width;
  final bool showPrimary;
  final bool showSecondary;
  AppButton({
    Key? key,
    required this.theme,
    required this.dappInfo,
    required this.radius,
    required this.height,
    required this.width,
    this.showPrimary = true,
    this.showSecondary = true,
  }) : super(key: key) {
    appButtonHandler = getIt<IAppButtonHandler>();
    packageManager = appButtonHandler.packageManager;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ISavedPwaCubit, SavedPwaState>(
        bloc: appButtonHandler.savedPwaCubit,
        buildWhen: (previous, current) {
          return previous.savedDapps[dappInfo.dappId!] !=
              current.savedDapps[dappInfo.dappId!];
        },
        builder: (BuildContext context, savedPwaState) {
          final savedDapp = savedPwaState.savedDapps[dappInfo.dappId];
          return BlocBuilder<IPackageManager, PackageManagerState>(
            bloc: packageManager,
            buildWhen: (previous, current) {
              return (previous.packageMapping![dappInfo.androidPackage!] !=
                      current.packageMapping![dappInfo.androidPackage!] ||
                  previous.packageMapping![dappInfo.androidPackage!]?.status !=
                      current
                          .packageMapping![dappInfo.androidPackage!]?.status);
            },
            builder: (context, state) {
              final packageInfo = state
                  .packageMapping![dappInfo.androidPackage ?? dappInfo.dappId];
              if (packageInfo == null &&
                  (dappInfo.availableOnPlatform?.contains("android") ??
                      false) &&
                  (dappInfo.androidPackage != null)) {
                return CustomElevatedButton(
                  onTap: () {
                    appButtonHandler.startDownload(dappInfo, context);
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
                return SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (showSecondary)
                        savedDapp == null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomElevatedButton(
                                  onTap: () {
                                    appButtonHandler.saveDapp(dappInfo);
                                  },
                                  color: theme.blue,
                                  radius: radius,
                                  width: 50,
                                  height: height,
                                  child: Text(
                                    context.getLocale!.save,
                                    style: theme.whiteBoldTextStyle,
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomElevatedButton(
                                  onTap: () {
                                    appButtonHandler.unsaveDapp(dappInfo);
                                  },
                                  color: theme.errorRed,
                                  radius: radius,
                                  width: 50,
                                  height: height,
                                  child: Text(
                                    context.getLocale!.remove,
                                    style: theme.whiteBoldTextStyle,
                                  ),
                                ),
                              ),
                      if (showPrimary)
                        CustomElevatedButton(
                          onTap: () {
                            appButtonHandler.openPwaApp(context, dappInfo);
                          },
                          color: theme.appGreen,
                          radius: radius,
                          width: width,
                          height: height,
                          child: Text(
                            context.getLocale!.openDapp,
                            style: theme.whiteBoldTextStyle,
                          ),
                        )
                    ],
                  ),
                );
              } else if (packageInfo?.status == DownloadTaskStatus.running ||
                  packageInfo?.status == DownloadTaskStatus.enqueued) {
                return CircularProgressIndicator.adaptive(
                  backgroundColor: theme.greyBlue,
                  valueColor: AlwaysStoppedAnimation<Color>(theme.blue),
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
              } else if ((packageInfo?.installed ?? false) &&
                  (packageInfo?.versionCode ?? 0) <
                      (double.tryParse(dappInfo.version ?? "0") ?? 0)) {
                return SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (showSecondary)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomElevatedButton(
                            onTap: () {
                              appButtonHandler.openApp(dappInfo);
                            },
                            color: theme.blue,
                            radius: radius,
                            width: 50,
                            height: height,
                            child: Text(
                              context.getLocale!.open,
                              style: theme.whiteBoldTextStyle,
                            ),
                          ),
                        ),
                      if (showPrimary)
                        CustomElevatedButton(
                          onTap: () {
                            appButtonHandler.startDownload(dappInfo, context);
                          },
                          color: theme.appGreen,
                          radius: radius,
                          width: width,
                          height: height,
                          child: Text(
                            context.getLocale!.update,
                            style: theme.whiteBoldTextStyle,
                          ),
                        ),
                    ],
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
              }
              return const SizedBox();
            },
          );
        });
  }
}
