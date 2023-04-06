import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/widgets/cards/default_card.dart';
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
          ],
        ),
      ),
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
}
