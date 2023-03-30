import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/widgets/buttons/app_button.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';

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
    final listTile = SizedBox(
      height: 42,
      child: ListTile(
        leading: SizedBox(
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
        ),
        title: Text(
          dappInfo.name!,
          style: theme.titleTextStyle,
        ),
        subtitle: Text(
          "${dappInfo.developer} · ${dappInfo.category}",
          style: theme.bodyTextStyle,
        ),
        trailing: AppButton(
          theme: theme,
          dappInfo: dappInfo,
          showPrimary: true,
          showSecondary: true,
          radius: 6,
          height: 34,
          width: 103,
        ),
      ),
    );
    return listTile;
  }
}
