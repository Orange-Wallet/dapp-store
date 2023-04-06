import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/package_manager_cubit.dart';
import 'package:dappstore/features/self_update/application/cubit/i_self_update_cubit.dart';
import 'package:dappstore/features/self_update/application/cubit/self_update_cubit.dart';
import 'package:dappstore/features/self_update/application/handler/i_self_update_handler.dart';
import 'package:dappstore/widgets/buttons/customizable_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SoftUpdateWidget extends StatelessWidget {
  ISelfUpdateHandler selfUpdateHandler = getIt<ISelfUpdateHandler>();
  IThemeCubit themeCubit = getIt<IThemeCubit>();
  SoftUpdateWidget({super.key});
  @override
  Widget build(BuildContext context) {
    IThemeSpec theme = themeCubit.theme;
    final Widget download = Icon(
      Icons.download_for_offline_outlined,
      color: theme.ratingGrey,
      size: MediaQuery.of(context).size.width * 0.6,
    );

    final Widget downloading = SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.width * 0.6,
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
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "New update is availbale, you need to update dApp store to continue using it.",
                    style: theme.normalTextStyle,
                  ),
                  CustomizableAppButton(
                    theme: theme,
                    installWidget: download,
                    installingWidget: downloading,
                    updateWidget: download,
                    progressIndicator: downloading,
                    dappInfo:
                        selfUpdateHandler.selfUpdateCubit.state.storeInfo!,
                    openWidget: const SizedBox(),
                    customDownloadFunction: selfUpdateHandler.triggerUpdate,
                  )
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
