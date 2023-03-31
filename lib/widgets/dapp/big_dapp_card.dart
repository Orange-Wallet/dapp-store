import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(handler.theme.buttonRadius),
          color: handler.theme.searchBigCardBG,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(handler.theme.buttonRadius),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: ImageWidgetCached(
                        dapp.images?.banner ?? dapp.images!.logo!,
                        key:
                            ValueKey(dapp.images?.banner ?? dapp.images!.logo!),
                        height: 52,
                        width: 52,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dapp.name ?? "N/A",
                          style: handler.theme.normalTextStyle2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${dapp.developer?.legalName ?? "N/A"} • ${dapp.category}",
                          style: handler.theme.secondaryTextStyle1,
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ],
                ),
                TextButton(
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
                      context.getLocale!.install,
                      style: handler.theme.smallButtonTextStyle,
                    )),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Divider(
              color: handler.theme.whiteColor.withOpacity(0.08),
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.getLocale!.ratings,
                  style: handler.theme.greyHeading,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        (dapp.metrics?.rating ?? "0").toString(),
                        style: handler.theme.secondaryTitleTextStyle,
                      ),
                    ),
                    RatingBar(
                      initialRating: dapp.metrics?.rating ?? 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20,
                      ratingWidget: RatingWidget(
                        full: Icon(
                          Icons.star,
                          color: handler.theme.ratingGrey,
                        ),
                        half: Icon(
                          Icons.star_half,
                          color: handler.theme.ratingGrey,
                        ),
                        empty: Icon(
                          Icons.star,
                          color: handler.theme.unratedGrey,
                        ),
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                  ],
                )
              ],
            ),
            Divider(
              color: handler.theme.whiteColor.withOpacity(0.08),
              height: 1,
            ),
            if (dapp.availableOnPlatform!.isNotEmpty &&
                dapp.availableOnPlatform!.contains('android'))
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.getLocale!.downloads,
                    style: handler.theme.greyHeading,
                  ),
                  Text(
                    (dapp.metrics?.downloads ?? 0).toString(),
                    style: handler.theme.secondaryTitleTextStyle,
                  ),
                ],
              ),
          ],
        ));
  }
}
