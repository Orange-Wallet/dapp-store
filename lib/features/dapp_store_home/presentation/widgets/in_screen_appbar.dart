import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/utils/image_constants.dart';
import 'package:flutter/material.dart';

class InScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IThemeSpec themeSpec;
  final List<Widget> actions;
  final emptyBox = const SizedBox();
  const InScreenAppBar(
      {super.key, required this.themeSpec, required this.actions});

  @override
  Widget build(BuildContext context) {
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
          Image.asset(
            ImageConstants.htcLogo,
            scale: 2.5,
          ),
          emptyBox,
          emptyBox,
        ],
      ),
      actions: [...actions],
    );
  }

  @override
  final Size preferredSize = const Size.fromHeight(52.0);
}
