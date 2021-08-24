import 'package:bazaar_bihar/GetxControllers/CartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

cartFooter(CartController _catCtrl) {
  double totalMrp = 0.0;
  double totalSp = 0.0;

  _catCtrl.carts.forEach((cart) => cart.products.forEach((product) {
        totalMrp += double.parse(product.markedPrice) * product.cartItemCount;
        totalSp += double.parse(product.sellingPrice) * product.cartItemCount;
      }));
  return [
    _catCtrl.carts.length > 0
        ? Container(
            width: Get.mediaQuery.size.width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Total MRP: ₹$totalMrp",
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.red.shade500,
                      ),
                    ),
                    Text(
                      "Payable amount: ₹$totalSp",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.purple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Get.theme.primaryColor),
                        ),
                        onPressed: () {
                          Get.offNamed("/checkout");
                        },
                        child: Text(
                          "Checkout",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        : Container()
  ];
}
