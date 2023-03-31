import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/custom_search_delegate.dart';
import 'package:dappstore/widgets/white_gradient_line.dart';
import 'package:flutter/material.dart';

class NormalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final emptyBox = const SizedBox();

  const NormalAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    IDappStoreHandler handler = DappStoreHandler();
    return AppBar(
      backgroundColor: handler.theme.appBarBackgroundColor,
      leading: InkWell(
        onTap: context.popRoute,
        child: Icon(
          Icons.arrow_back,
          color: handler.theme.whiteColor,
        ),
      ),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          emptyBox,
          Text(
            title,
            style: handler.theme.secondaryTitleTextStyle,
          ),
          emptyBox,
          emptyBox,
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate:
                      CustomSearchDelegate(handler: handler, context: context));
            },
            icon: Icon(Icons.search, color: handler.theme.whiteColor)),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: handler.theme.whiteColor,
            ))
      ],
      bottom: const WhiteGradientLine(),
    );
  }

  @override
  final Size preferredSize = const Size.fromHeight(52.0);
}
