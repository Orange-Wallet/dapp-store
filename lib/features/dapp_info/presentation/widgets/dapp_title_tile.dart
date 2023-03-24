import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:dappstore/widgets/buttons/elevated_button.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';

class DappTitleTile extends StatelessWidget {
  final IDappInfoHandler dappInfoHandler;
  const DappTitleTile({super.key, required this.dappInfoHandler});

  @override
  Widget build(BuildContext context) {
    final dappInfo = dappInfoHandler.dappInfoCubit.state.dappInfo;
    final theme = dappInfoHandler.themeCubit.theme;
    final listTile = ListTile(
      leading: SizedBox(
        height: 55,
        width: 55,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ImageWidget(
            dappInfo!.images!.logo!,
            fit: BoxFit.fill,
            enableNetworkCache: true,
            height: 42,
            width: 42,
            keepAlive: true,
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
        onTap: () {},
        color: theme.appGreen,
        radius: 6,
        height: 34,
        width: 103,
        child: Text(
          context.getLocale!.installdApp,
          style: theme.whiteBoldTextStyle,
        ),
      ),
    );
    return listTile;
  }
}
