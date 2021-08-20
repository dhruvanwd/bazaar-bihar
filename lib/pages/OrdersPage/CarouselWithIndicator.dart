import 'package:bazaar_bihar/components/CachedImageManager.dart';
import 'package:bazaar_bihar/models/ImagesModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<ImageModel> images;
  const CarouselWithIndicator(this.images);
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              enlargeCenterPage: true,
              viewportFraction: 1,
              aspectRatio: 1,
              enableInfiniteScroll: false,
              height: 250,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: widget.images
                .map(
                  (image) => CachedImageMananger(image),
                )
                .toList(),
          ),
          Visibility(
            visible: widget.images.length > 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.images.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Get.theme.brightness == Brightness.dark
                                ? Colors.white
                                : Colors.purple)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
