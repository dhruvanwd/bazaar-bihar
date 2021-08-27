import 'dart:math';

import 'package:flutter/cupertino.dart';

final randomLoader = new Random();

final List<String> loaders = [
  "images/loaders/circularOutlined.gif",
  "images/loaders/circularCapped.gif",
  "images/loaders/circularBalls.gif",
  "images/loaders/catLoader.gif",
  "images/loaders/geometry.gif",
  "images/loaders/classicLoader.gif",
];

class RandomImageLoaders extends StatelessWidget {
  RandomImageLoaders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      loaders[randomLoader.nextInt(loaders.length)],
      fit: BoxFit.cover,
    );
  }
}
