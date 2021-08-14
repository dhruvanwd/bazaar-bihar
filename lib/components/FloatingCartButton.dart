import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FloatingCartButton extends StatefulWidget {
  const FloatingCartButton({Key? key, required this.parentContext})
      : super(key: key);
  final parentContext;
  @override
  _FloatingCartButtonState createState() => _FloatingCartButtonState();
}

class _FloatingCartButtonState extends State<FloatingCartButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      onPressed: () {
        Get.toNamed('/cart');
      },
      child: Icon(
        Icons.shopping_cart,
      ),
    );
  }
}
