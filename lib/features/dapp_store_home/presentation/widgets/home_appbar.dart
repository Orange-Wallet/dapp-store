import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/custom_search_delegate.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/features/wallet_connect/presentation/wallet_connect_screen.dart';
import 'package:dappstore/utils/image_constants.dart';
import 'package:dappstore/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:dappstore/widgets/white_gradient_line.dart';
import 'package:flutter/material.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    IDappStoreHandler handler = DappStoreHandler();
    return AppBar(
      backgroundColor: handler.theme.appBarBackgroundColor,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Image.asset(
          ImageConstants.htcLogo,
        ),
      ),
      // title: TextField(),
      actions: [
        IconButton(
            onPressed: () async {
              await getIt<IWalletConnectCubit>().disconnectAll();
              context.replaceRoute(const WalletConnectScreen());
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate:
                      CustomSearchDelegate(handler: handler, context: context));
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {
              context.showBottomSheet(handler.theme);
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            )),
      ],
      bottom: const WhiteGradientLine(),
    );
  }

  @override
  final Size preferredSize = const Size.fromHeight(52.0);
}
