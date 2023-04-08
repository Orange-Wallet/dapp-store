import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_info/application/dapp_info_cubit.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:dappstore/features/dapp_info/application/i_dapp_info_cubit.dart';
import 'package:dappstore/features/dapp_info/presentation/widgets/add_rating_card.dart';
import 'package:dappstore/features/dapp_info/presentation/widgets/rating_popup_widget.dart';
import 'package:dappstore/widgets/cards/default_card.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

typedef RatingCallback = void Function(double rating);

class RatingCard extends StatefulWidget {
  final IThemeSpec theme;
  final double rating;
  final IDappInfoHandler handler;
  const RatingCard({
    super.key,
    required this.theme,
    this.rating = 0,
    required this.handler,
  });

  @override
  State<RatingCard> createState() => _RatingCardState();
}

class _RatingCardState extends State<RatingCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IDappInfoCubit, DappInfoState>(
        bloc: widget.handler.dappInfoCubit,
        builder: (context, state) {
          return DefaultCard(
            theme: widget.theme,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  AddRatingCard(
                    handler: widget.handler,
                    initialRating: widget.rating,
                    ratingUpdateCallback: (value) {
                      widget.handler.showRatingPopup(
                        context,
                        RatingPopupWidget(
                            handler: widget.handler, initialRating: value),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Other review",
                        style: widget.theme.whiteBoldTextStyle,
                      ),
                      TextButton(
                          onPressed: () {
                            // context.showBottomSheet(
                            //     theme: widget.theme, child: dialog());
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
                  if (state.ratings.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.ratings.length,
                      itemBuilder: ((context, index) {
                        final rating = state.ratings[index];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            reviewTile(
                              name: rating.username ?? "",
                              description: rating.comment ?? "",
                              rating: rating.rating ?? 0,
                            ),
                            Divider(
                              color: widget.theme.whiteColor.withOpacity(0.08),
                              height: 1,
                            ),
                          ],
                        );
                      }),
                    ),
                ],
              ),
            ),
          );
        });
  }

  Widget reviewTile({
    required String name,
    required String description,
    required int rating,
  }) {
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
}
