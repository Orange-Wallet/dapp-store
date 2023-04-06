import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:dappstore/widgets/cards/default_card.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

typedef RatingCallback = void Function(double rating);

class RatingCard extends StatefulWidget {
  final IThemeSpec theme;
  final RatingCallback callback;
  final double rating;

  const RatingCard({
    super.key,
    required this.theme,
    this.rating = 0,
    required this.callback,
  });

  @override
  State<RatingCard> createState() => _RatingCardState();
}

class _RatingCardState extends State<RatingCard> {
  @override
  Widget build(BuildContext context) {
    return DefaultCard(
      theme: widget.theme,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            addRatingCard(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Other review",
                  style: widget.theme.whiteBoldTextStyle,
                ),
                TextButton(
                    onPressed: () {
                      context.showBottomSheet(
                          theme: widget.theme, child: dialog());
                    },
                    child: Text(
                      "View all",
                      style: widget.theme.bodyTextStyle,
                    ))
              ],
            ),
            Divider(
              color: widget.theme.whiteColor.withOpacity(0.08),
              height: 1,
            ),
            reviewTile(),
            Divider(
              color: widget.theme.whiteColor.withOpacity(0.08),
              height: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget reviewTile() {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  const ImageWidgetCached(
                    "https://avatars.githubusercontent.com/u/82613752?s=200&v=4",
                    height: 15,
                    width: 15,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    "Namerere",
                    style: widget.theme.normalTextStyle,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    "•",
                    style: widget.theme.bodyTextStyle,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    "02/23/23",
                    style: widget.theme.bodyTextStyle,
                  )
                ],
              ),
            ),
            RatingBar(
              initialRating: 3, // get rating here
              itemCount: 5,
              itemSize: 12,
              ratingWidget: RatingWidget(
                full: Icon(
                  Icons.star,
                  color: widget.theme.ratingGrey,
                ),
                half: Icon(
                  Icons.star_half,
                  color: widget.theme.ratingGrey,
                ),
                empty: Icon(
                  Icons.star,
                  color: widget.theme.unratedGrey,
                ),
              ),
              ignoreGestures: true,
              onRatingUpdate: (_) {},
              allowHalfRating: true,
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          "long text ong text ong text ong text ong text ong text ong text ong text ong text ong text ong text ong text ong text ong text ong text ong text ong text ong text ong text ong text ong text ong text ong text ong text ong text ong text ong text ong text ",
          style: widget.theme.bodyTextStyle,
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }

  Widget addRatingCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.getLocale!.addRating,
          style: widget.theme.titleTextExtraBold,
        ),
        RatingBar(
          initialRating: widget.rating,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 25,
          ratingWidget: RatingWidget(
            full: Icon(
              Icons.star,
              color: widget.theme.ratingGrey,
            ),
            half: Icon(
              Icons.star_half,
              color: widget.theme.ratingGrey,
            ),
            empty: Icon(
              Icons.star,
              color: widget.theme.unratedGrey,
            ),
          ),
          onRatingUpdate: widget.callback,
        ),
      ],
    );
  }

  Widget dialog() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  context.popRoute();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: widget.theme.whiteColor,
                ),
              ),
              Text(
                context.getLocale!.addRating,
                style: widget.theme.whiteBoldTextStyle,
              ),
              InkWell(
                onTap: () {
                  context.popRoute();
                },
                child: Icon(
                  Icons.close,
                  color: widget.theme.whiteColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          addRatingCard(),
          const SizedBox(
            height: 16,
          ),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
                hintText: context.getLocale!.writeAboutTheApp,
                hintStyle: widget.theme.bodyTextStyle,
                border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(widget.theme.buttonRadius),
                    borderSide:
                        BorderSide(color: widget.theme.appBarBackgroundColor))),
            style: widget.theme.normalTextStyle,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: widget.theme.wcBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(widget.theme.buttonRadius),
                      ),
                    ),
                    child: Text(
                      context.getLocale!.shareReview,
                      style: widget.theme.whiteBoldTextStyle,
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
