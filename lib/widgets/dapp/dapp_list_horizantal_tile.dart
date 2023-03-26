import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';

class DappListHorizantal extends StatelessWidget {
  final DappInfo dapp;
  final IDappStoreHandler handler;

  const DappListHorizantal({
    required this.dapp,
    required this.handler,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                height: 120,
                width: 120,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(handler.theme.imageBorderRadius),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: ImageWidgetCached(
                    dapp.images!.logo!,
                    key: ValueKey(dapp.images!.logo!),
                    height: 40,
                    width: 40,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dapp.name ?? "N/A",
                        style: handler.theme.normalTextStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
