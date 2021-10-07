import '../Utils/utils.dart';
import './ImageError.dart';
import './RandomImageLoaders.dart';
import '../models/ImagesModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImageMananger extends StatelessWidget {
  final ImageModel image;
  CachedImageMananger(this.image);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: createImageUrl(image),
      placeholder: (context, url) => RandomImageLoaders(),
      errorWidget: (context, url, error) => ImageError(),
    );
  }
}
