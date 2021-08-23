import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/components/ImageError.dart';
import 'package:bazaar_bihar/components/RandomImageLoaders.dart';
import 'package:bazaar_bihar/models/ImagesModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImageMananger extends StatelessWidget {
  final ImageModel image;
  CachedImageMananger(this.image);
  final _ = GlobalController.to;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: _.createImageUrl(image),
      placeholder: (context, url) => RandomImageLoaders(),
      errorWidget: (context, url, error) => ImageError(),
    );
  }
}
