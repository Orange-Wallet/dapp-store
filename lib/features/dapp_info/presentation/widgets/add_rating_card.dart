import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/widgets/cards/default_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

typedef RatingCallback = void Function(double rating);

class AddRatingCard extends StatelessWidget {
  final IThemeSpec theme;
  final RatingCallback callback;
  final double rating;

  const AddRatingCard({
    super.key,
    required this.theme,
    this.rating = 0,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultCard(
      theme: theme,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.getLocale!.addRating,
              style: theme.titleTextStyle,
            ),
            RatingBar(
              initialRating: rating,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 25,
              ratingWidget: RatingWidget(
                full: Icon(
                  Icons.star,
                  color: theme.ratingGrey,
                ),
                half: Icon(
                  Icons.star_half,
                  color: theme.ratingGrey,
                ),
                empty: Icon(
                  Icons.star,
                  color: theme.unratedGrey,
                ),
              ),
              onRatingUpdate: callback,
            ),
          ],
        ),
      ),
    );
  }
}
