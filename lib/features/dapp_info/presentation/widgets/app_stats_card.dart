import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';

class AppStatsCard extends StatelessWidget {
  final IDappInfoHandler dappInfoHandler;
  const AppStatsCard({super.key, required this.dappInfoHandler});

  @override
  Widget build(BuildContext context) {
    final theme = dappInfoHandler.themeCubit.theme;
    return Card(
      shape: theme.cardShape,
      color: theme.cardColor,
      child: Column(children: [Text(context.getLocale!.details)]),
    );
  }
}
