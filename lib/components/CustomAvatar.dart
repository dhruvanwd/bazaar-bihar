import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final Widget child;
  final double size;
  CustomAvatar({required this.child, this.size = 140.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: child,
      ),
    );
  }
}
