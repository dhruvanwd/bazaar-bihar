import 'package:flutter/material.dart';
import 'package:get/get.dart';

emptyCart() {
  return Container(
    height: Get.mediaQuery.size.height,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "Cart Is Empty !",
              style:
                  Get.theme.textTheme.headline6!.copyWith(color: Colors.orange),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "Go Back",
            ),
          )
        ],
      ),
    ),
  );
}
