import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/package_manager_cubit.dart';
import 'package:dappstore/widgets/buttons/app_button.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DappTitleTile extends StatelessWidget {
  final DappInfo dappInfo;
  final IThemeSpec theme;
  final bool primaryTile;
  const DappTitleTile(
      {super.key,
      required this.theme,
      required this.dappInfo,
      required this.primaryTile});

  @override
  Widget build(BuildContext context) {
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
    final listWithoutTrailing = SizedBox(
      height: 42,
      child: ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
      ),
    );
    return BlocBuilder<IPackageManager, PackageManagerState>(
      bloc: getIt<IPackageManager>(),
      builder: (context, state) {
        if (!(dappInfo.availableOnPlatform?.contains("android") ?? false)) {
          return listWithoutTrailing;
        }
        if (dappInfo.availableOnPlatform?.contains("android") ?? false) {
          if (state.packageMapping![dappInfo.androidPackage] == null) {
          } else {
            if ((state.packageMapping![dappInfo.androidPackage]?.versionCode ??
                    0) <
                double.parse(dappInfo.version ?? "0")) {
              return Container();
            } else {}
          }
        }
        return Container();
      },
    );
  }
}
