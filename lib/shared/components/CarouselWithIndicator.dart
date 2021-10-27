import 'dart:io';

import './CachedImageManager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<dynamic> images;
  final double aspectRatio;
  const CarouselWithIndicator(this.images, {this.aspectRatio = 1});
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    bool isFileList = widget.images.every((img) => img is File);
    if (widget.images.length == 0) return Container();

    return Container(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              enlargeCenterPage: true,
              viewportFraction: 1,
              aspectRatio: widget.aspectRatio,
              enableInfiniteScroll: false,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: widget.images
                .map(
                  (image) => isFileList
                      ? Container(
                          width: Get.mediaQuery.size.width,
                          child: Image.file(
                            File(image.path),
                            fit: BoxFit.cover,
                          ),
                        )
                      : CachedImageMananger(image),
                )
                .toList(),
          ),
          Positioned(
            child: Visibility(
              visible: widget.images.length > 1,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.images.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Get.theme.brightness == Brightness.dark
                                    ? Colors.purple
                                    : Colors.white)
                                .withOpacity(
                                    _current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            bottom: 2,
          )
        ],
      ),
    );
  }
}
