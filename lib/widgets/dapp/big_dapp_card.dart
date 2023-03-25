import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';

class BigDappCard extends StatelessWidget {
  final DappInfo dapp;
  final IDappStoreHandler handler;

  const BigDappCard({
    required this.dapp,
    required this.handler,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(handler.theme.imageBorderRadius),
            ),
            clipBehavior: Clip.antiAlias,
            child: ImageWidgetCached(
              dapp.images?.banner ?? dapp.images!.logo!,
              key: ValueKey(dapp.images?.banner ?? dapp.images!.logo!),
              height: 165,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dapp.name ?? "N/A",
                style: handler.theme.titleTextStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                dapp.description ?? "N/A",
                style: handler.theme.bodyTextStyle,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                    onPressed: () {
                      // TODO install implementation
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        handler.theme.secondaryBackgroundColor,
                      ),
                    ),
                    child: Text(
                      "${context.getLocale!.install} ${dapp.name}",
                      style: handler.theme.smallButtonTextStyle,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
