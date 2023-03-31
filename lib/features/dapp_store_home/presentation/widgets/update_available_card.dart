import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/utils/image_constants.dart';
import 'package:flutter/material.dart';

class UpdateAvailableCard extends StatelessWidget {
  const UpdateAvailableCard({super.key});

  @override
  Widget build(BuildContext context) {
    IDappStoreHandler handler = DappStoreHandler();
    return Container(
        width: double.maxFinite,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(handler.theme.buttonRadius),
            color: handler.theme.cardBlue.withOpacity(1)),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                ImageConstants.update,
                scale: 2.7,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "15 ${context.getLocale!.dappsReadyToUpdate}",
                      style: handler.theme.normalTextStyle2,
                    ),
                    Text(
                      context.getLocale!.updateYourDapps,
                      softWrap: true,
                      style: handler.theme.secondaryWhiteTextStyle3,
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
