import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ConnectAndExploreCard extends StatelessWidget {
  const ConnectAndExploreCard({super.key});

  @override
  Widget build(BuildContext context) {
    DappStoreHandler handler = DappStoreHandler();

    return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        color: handler.theme.secondaryBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.getLocale!.htcDappStore,
              style: handler.theme.secondaryTextStyle1,
            ),
            Text(
              context.getLocale!.exploreTheBestDapps,
              style: handler.theme.headingTextStyle,
            ),
            const SizedBox(
              height: 90,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: handler.theme.appBarBackgroundColor,
                    child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            backgroundColor: handler.theme.backgroundColor,
                            padding: const EdgeInsets.symmetric(vertical: 8)),
                        child: Text(
                          context.getLocale!.connectWallet,
                          style: handler.theme.buttonTextStyle,
                        )),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
