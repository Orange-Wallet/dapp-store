import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/utils/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    DappStoreHandler handler = DappStoreHandler();
    return AppBar(
      backgroundColor: handler.theme.appBarBackgroundColor,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Image.asset(ImageConstants.htcLogo),
      ),
      // title: TextField(),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ))
      ],
    );
  }

  @override
  final Size preferredSize = const Size.fromHeight(52.0);
}
