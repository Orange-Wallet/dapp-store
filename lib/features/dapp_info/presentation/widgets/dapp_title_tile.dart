import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/widgets/buttons/elevated_button.dart';
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
      height: 60,
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListTile(
        leading: SizedBox(
          height: 55,
          width: 55,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ImageWidget(
              dappInfo.images?.logo! ?? "",
              fit: BoxFit.fill,
              enableNetworkCache: true,
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
        trailing: CustomElevatedButton(
          onTap: () {
            //todo: set logic
          },
          color: primaryTile ? theme.appGreen : theme.ratingGrey,
          radius: 6,
          height: 34,
          width: 103,
          child: Text(
            context.getLocale!.installdApp,
            style: theme.whiteBoldTextStyle,
          ),
        ),
      ),
    );
    return listTile;
  }
}
