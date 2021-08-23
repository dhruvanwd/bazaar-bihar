import 'package:flutter/material.dart';

class ImageError extends StatelessWidget {
  const ImageError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.linearToSrgbGamma(),
              image: ExactAssetImage("images/logo.png"))),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white24,
          ),
          child: Text(
            "Image not found !",
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
