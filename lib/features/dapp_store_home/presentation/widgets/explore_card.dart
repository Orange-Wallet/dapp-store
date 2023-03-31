import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/utils/image_constants.dart';
import 'package:flutter/material.dart';

class ExploreCard extends StatelessWidget {
  const ExploreCard({super.key});

  @override
  Widget build(BuildContext context) {
    DappStoreHandler handler = DappStoreHandler();

    return Container(
        padding: const EdgeInsets.only(left: 32, top: 16, bottom: 16),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                ImageConstants.explore,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    context.getLocale!.htcDappStore,
                    style: handler.theme.secondaryTextStyle1,
                  ),
                  Text.rich(
                    TextSpan(
                      text: "${context.getLocale!.exploreTheBestDapps} ",
                      style: handler.theme.exploreCardTitle,
                      children: <TextSpan>[
                        TextSpan(
                          text: context.getLocale!.createdByCommunity,
                          style: handler.theme.exploreCardTitleBold,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
