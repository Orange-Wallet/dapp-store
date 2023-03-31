import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';

class DappListTile extends StatelessWidget {
  final DappInfo dapp;
  final IDappStoreHandler handler;
  final bool isThreeLines;

  const DappListTile({
    required this.dapp,
    required this.handler,
    this.isThreeLines = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(handler.theme.buttonRadius),
            ),
            clipBehavior: Clip.antiAlias,
            child: ImageWidgetCached(
              dapp.images!.logo!,
              key: ValueKey(dapp.images!.logo!),
              height: 64,
              width: 64,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dapp.name ?? "N/A",
                    style: handler.theme.titleTextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    dapp.description ?? "N/A",
                    style: handler.theme.bodyTextStyle,
                    maxLines: isThreeLines ? 1 : 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (isThreeLines)
                    Row(
                      children: [
                        Text(
                          dapp.metrics?.rating?.toString() ?? "0",
                          style: handler.theme.bodyTextStyle,
                        ),
                        Icon(
                          Icons.star,
                          color: handler.theme.bodyTextColor,
                          size: handler.theme.bodyTextStyle.fontSize,
                        )
                      ],
                    )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Icon(
              Icons.arrow_forward,
              color: handler.theme.whiteColor,
            ),
          )
        ],
      ),
    );
  }
}
