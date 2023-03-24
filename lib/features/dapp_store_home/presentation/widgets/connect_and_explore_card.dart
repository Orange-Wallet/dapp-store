import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:flutter/material.dart';

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
                  child: TextButton(
                      onPressed: () {
                        // TODO add connect wallet implementation
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            handler.theme.appBarBackgroundColor),
                      ),
                      child: Text(
                        context.getLocale!.connectWallet,
                        style: handler.theme.buttonTextStyle,
                      )),
                ),
              ],
            ),
          ],
        ));
  }
}
