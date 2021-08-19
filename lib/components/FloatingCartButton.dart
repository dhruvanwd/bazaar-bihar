import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/CartController.dart';

class FloatingCartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (_) => FloatingActionButton(
        mini: true,
        onPressed: () {
          Get.toNamed('/cart');
        },
        child: Badge(
          badgeContent: Text(
            _.products.length.toString(),
            style: TextStyle(color: Colors.white),
          ),
          child: Icon(
            Icons.shopping_cart,
          ),
        ),
      ),
    );
  }
}
