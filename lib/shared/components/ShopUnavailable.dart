import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopUnavailable extends StatelessWidget {
  final String label;
  const ShopUnavailable(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("images/shop-vector.jpg"),
        ),
      ),
      height: 200,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: Get.theme.textTheme.headline5!.copyWith(
              color: Colors.deepOrange,
            ),
          ),
        ),
      ),
    );
  }
}
