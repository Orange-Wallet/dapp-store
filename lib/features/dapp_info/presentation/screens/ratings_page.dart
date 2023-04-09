import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/constants/routes.dart';
import 'package:dappstore/core/router/interface/route.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_info/presentation/widgets/review_tile.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/post_rating.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/in_screen_appbar.dart';
import 'package:flutter/material.dart';

class RatingsScreen extends StatelessScreen {
  final IThemeSpec theme;
  final List<PostRating> ratingsList;

  const RatingsScreen({
    super.key,
    required this.theme,
    required this.ratingsList,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: InScreenAppBar(
        themeSpec: theme,
        title: context.getLocale!.ratingsAndReviews,
      ),
      body: ListView.builder(
        itemCount: ratingsList.length,
        itemBuilder: ((context, index) {
          final rating = ratingsList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                ReviewTile(
                  address: rating.userAddress ?? rating.username ?? "null",
                  theme: theme,
                  name: rating.username ?? "",
                  description: rating.comment ?? "",
                  rating: rating.rating ?? 0,
                ),
                Divider(
                  color: theme.whiteColor.withOpacity(0.3),
                  height: 1,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  @override
  String get route => Routes.ratingsScreen;
}
