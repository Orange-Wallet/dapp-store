import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/custom_search_delegate.dart';
import 'package:dappstore/widgets/white_gradient_line.dart';
import 'package:flutter/material.dart';

class InScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IThemeSpec themeSpec;
  final String title;
  final emptyBox = const SizedBox();
  final actionWidgets;
  const InScreenAppBar(
      {super.key,
      required this.themeSpec,
      required this.title,
      this.actionWidgets = const []});

  @override
  Widget build(BuildContext context) {
    IDappStoreHandler handler = DappStoreHandler();
    return AppBar(
      backgroundColor: themeSpec.appBarBackgroundColor,
      leading: InkWell(
        onTap: () {
          final handler = DappStoreHandler();
          handler.setActiveDappId(dappId: "");
          context.popRoute();
        },
        child: Icon(
          Icons.arrow_back,
          color: themeSpec.whiteColor,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          emptyBox,
          Text(
            title,
            style: themeSpec.secondaryTitleTextStyle,
          ),
          emptyBox,
          emptyBox,
        ],
      ),
      actions: [...actionWidgets],
      bottom: const WhiteGradientLine(),
    );
  }

  @override
  final Size preferredSize = const Size.fromHeight(52.0);
}
