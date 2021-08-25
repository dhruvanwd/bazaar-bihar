import 'package:bazaar_bihar/GetxControllers/CartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

cartFooter(Widget actionBtn) {
  final _catCtrl = CartController.to;
  Map orderPriceInfo = _catCtrl.getOrderPriceSummary();
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
                      "Total MRP: ₹${orderPriceInfo['totalMrp']}",
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.red.shade500,
                      ),
                    ),
                    Text(
                      "Payable amount: ₹${orderPriceInfo['totalSp']}",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.purple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                actionBtn,
              ],
            ),
          )
        : Container()
  ];
}
