import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> imageUrls;
  final double height;
  ImageCarousel({super.key, required this.imageUrls, required this.height});
  final PageController pageController = PageController(viewportFraction: 0.33);

  @override
  Widget build(BuildContext context) {
    final images = imageUrls
        .map((e) => Container(
              margin: const EdgeInsets.all(5),
              child: ImageWidget(
                e,
                enableNetworkCache: true,
                fit: BoxFit.cover,
              ),
            ))
        .toList();
    return Stack(
      children: [
        Center(
          child: SizedBox(
            height: height,
            child: PageView.builder(
              pageSnapping: true,
              padEnds: false,
              controller: pageController,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return images[index];
              },
            ),
          ),
        ),
        PositionedDirectional(
            end: 5,
            top: 5,
            bottom: 5,
            child: ElevatedButton(
              child: const SizedBox(
                height: 10,
                child: Icon(Icons.arrow_right),
              ),
              onPressed: () {},
            )),
        PositionedDirectional(
            bottom: 5,
            top: 5,
            start: 5,
            child: ElevatedButton(
              child: const SizedBox(
                height: 10,
                child: Icon(Icons.arrow_left),
              ),
              onPressed: () {},
            )),
      ],
    );
  }
}
