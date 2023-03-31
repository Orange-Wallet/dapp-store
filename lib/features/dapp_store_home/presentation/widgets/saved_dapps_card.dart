import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/utils/image_constants.dart';
import 'package:flutter/material.dart';

class SavedDappscard extends StatelessWidget {
  const SavedDappscard({super.key});

  @override
  Widget build(BuildContext context) {
    IDappStoreHandler handler = DappStoreHandler();
    return Container(
        width: double.maxFinite,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(handler.theme.buttonRadius),
            color: handler.theme.cardGrey),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                ImageConstants.saved,
                scale: 2.6,
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
                    Row(
                      children: [
                        Text(
                          "${context.getLocale!.youHave} ",
                          style: handler.theme.normalTextStyle,
                        ),
                        Text(
                          "15 ${context.getLocale!.webDapps} ",
                          style: handler.theme.normalTextStyle2,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          context.getLocale!.viewAll,
                          style: handler.theme.secondaryWhiteTextStyle3,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: handler.theme.whiteColor,
                          size: handler.theme.secondaryWhiteTextStyle3.fontSize,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
