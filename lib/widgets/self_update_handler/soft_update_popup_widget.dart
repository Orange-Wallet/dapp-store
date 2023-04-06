import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/package_manager_cubit.dart';
import 'package:dappstore/features/self_update/application/cubit/i_self_update_cubit.dart';
import 'package:dappstore/features/self_update/application/cubit/self_update_cubit.dart';
import 'package:dappstore/features/self_update/application/handler/i_self_update_handler.dart';
import 'package:dappstore/utils/icon_constants.dart';
import 'package:dappstore/widgets/buttons/customizable_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class UpdateWidget extends StatelessWidget {
  bool isHardUpdate;
  ISelfUpdateHandler selfUpdateHandler = getIt<ISelfUpdateHandler>();
  IThemeCubit themeCubit = getIt<IThemeCubit>();
  UpdateWidget({super.key, this.isHardUpdate = false});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.25;
    IThemeSpec theme = themeCubit.theme;
    final Widget download = Image.asset(
      IconConstants.downloadIcon,
      color: theme.ratingGrey,
      height: size,
      width: size,
    );

    final Widget downloading = SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator.adaptive(
        backgroundColor: theme.greyBlue,
        valueColor: AlwaysStoppedAnimation<Color>(theme.blue),
      ),
    );

    return BlocBuilder<ISelfUpdateCubit, SelfUpdateState>(
      bloc: selfUpdateHandler.selfUpdateCubit,
      builder: (context, state) {
        return BlocBuilder<IPackageManager, PackageManagerState>(
          bloc: selfUpdateHandler.packageManager,
          builder: ((context, state) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 20),
                    child: Text(
                      isHardUpdate
                          ? context.getLocale!.hardUpdateText
                          : context.getLocale!.softUpdateText,
                      style: theme.titleTextStyle
                          .copyWith(color: theme.ratingGrey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomizableAppButton(
                      theme: theme,
                      installWidget: download,
                      installingWidget: downloading,
                      updateWidget: download,
                      progressIndicator: downloading,
                      dappInfo:
                          selfUpdateHandler.selfUpdateCubit.state.storeInfo!,
                      openWidget: const SizedBox(),
                      customDownloadFunction: selfUpdateHandler.triggerUpdate,
                    ),
                  ),
                  const SizedBox(),
                  const SizedBox()
                ],
              ),
            );
          }),
        );
      },
    );
  }
}