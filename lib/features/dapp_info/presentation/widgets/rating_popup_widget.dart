import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:dappstore/features/dapp_info/presentation/widgets/add_rating_card.dart';
import 'package:flutter/material.dart';

class RatingPopupWidget extends StatelessWidget {
  final IDappInfoHandler handler;
  final double initialRating;
  const RatingPopupWidget({
    super.key,
    required this.handler,
    required this.initialRating,
  });

  @override
  Widget build(BuildContext context) {
    double rating = initialRating;
    final IThemeSpec theme = handler.themeCubit.theme;
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
                  color: theme.whiteColor,
                ),
              ),
              Text(
                context.getLocale!.addRating,
                style: theme.whiteBoldTextStyle,
              ),
              InkWell(
                onTap: () {
                  context.popRoute();
                },
                child: Icon(
                  Icons.close,
                  color: theme.whiteColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          AddRatingCard(
            handler: handler,
            initialRating: initialRating,
            ratingUpdateCallback: (value) {
              rating = value;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
                hintText: context.getLocale!.writeAboutTheApp,
                hintStyle: theme.bodyTextStyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(theme.buttonRadius),
                    borderSide:
                        BorderSide(color: theme.appBarBackgroundColor))),
            style: theme.normalTextStyle,
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
                      backgroundColor: theme.wcBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(theme.buttonRadius),
                      ),
                    ),
                    child: Text(
                      context.getLocale!.shareReview,
                      style: theme.whiteBoldTextStyle,
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
