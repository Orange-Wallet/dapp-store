import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> imageUrls;
  ImageCarousel({
    super.key,
    required this.imageUrls,
  });
  final PageController pageController =
      PageController(viewportFraction: 0.33334, keepPage: false);
  final IDappInfoHandler dappInfoHandler = getIt<IDappInfoHandler>();

  @override
  Widget build(BuildContext context) {
    final theme = dappInfoHandler.themeCubit.theme;
    final images = imageUrls
        .map((e) => Container(
              margin: const EdgeInsets.all(5),
              child: ImageWidget(
                e,
                enableNetworkCache: true,
                fit: BoxFit.cover,
                keepAlive: true,
                width: 115,
              ),
            ))
        .toList();
    return Stack(
      children: [
        Center(
          child: SizedBox(
            height: 218,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: PageView.builder(
                padEnds: false,
                pageSnapping: false,
                controller: pageController,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return images[index];
                },
              ),
            ),
          ),
        ),
        PositionedDirectional(
          end: 4,
          top: 5,
          bottom: 5,
          child: SizedBox(
            height: 10,
            child: Container(
              height: 18.5,
              width: 18.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.arrowButtonBackgroundColor,
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: theme.whiteColor,
                size: 15,
              ),
            ),
          ),
        ),
        PositionedDirectional(
          bottom: 5,
          top: 5,
          start: 4,
          child: Container(
            height: 18.5,
            width: 18.5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.arrowButtonBackgroundColor,
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: theme.whiteColor,
              size: 15,
            ),
          ),
        ),
      ],
    );
  }
}
