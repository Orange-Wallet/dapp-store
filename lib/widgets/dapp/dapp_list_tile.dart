import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';

class DappListTile extends StatelessWidget {
  final DappInfo dapp;
  final IDappStoreHandler handler;

  const DappListTile({
    required this.dapp,
    required this.handler,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(handler.theme.imageBorderRadius),
            ),
            clipBehavior: Clip.hardEdge,
            child: ImageWidgetCached(
              dapp.images!.logo!,
              key: ValueKey(dapp.images!.logo!),
              height: 60,
              width: 60,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
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
            ),
          ),
          InkWell(
            onTap: () {
              //TODO add install logic
            },
            child: Container(
              height: 30,
              width: 50,
              color: handler.theme.secondaryBackgroundColor,
              child: Center(
                child: Text(
                  context.getLocale!.add,
                  style: handler.theme.smallButtonTextStyle,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
