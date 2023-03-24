import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:flutter/material.dart';

class AppDescriptionBox extends StatelessWidget {
  final IDappInfoHandler dappInfoHandler;
  const AppDescriptionBox({super.key, required this.dappInfoHandler});
  @override
  Widget build(BuildContext context) {
    final dappInfo = dappInfoHandler.dappInfoCubit.state.dappInfo;
    final theme = dappInfoHandler.themeCubit.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.getLocale!.aboutApp(dappInfo!.name!),
            style: theme.titleTextStyle,
          ),
          Text(
            dappInfo.description!,
            maxLines: null,
            style: theme.bodyTextStyle,
          )
        ],
      ),
    );
  }
}
