import 'package:bazaar_bihar/GetxControllers/CartController.dart';
import 'package:bazaar_bihar/models/PaymentInfoModal.dart';
import 'package:bazaar_bihar/pages/CartPage/CollapsableCartFooter.dart';
import 'package:bazaar_bihar/pages/CartPage/GenShopDetail.dart';
import 'package:bazaar_bihar/pages/CartPage/ShopWiseBill.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartFooter extends StatelessWidget {
  final actionBtn;
  final showRemoveCart;
  CartFooter({required this.actionBtn, required this.showRemoveCart});
  final _catCtrl = CartController.to;

  @override
  Widget build(BuildContext context) {
    final PaymentInfoModal orderPriceInfo = _catCtrl.getOrderPriceSummary();
    print("------------orderPriceInfo-------------");
    print(orderPriceInfo);
    return _catCtrl.carts.length > 0
        ? Container(
            width: Get.mediaQuery.size.width,
            child: Column(
              children: [
                Expanded(
                  child: CollapsableCartFooter(
                    genShopDetail(
                      orderPriceInfo.shopWiseInfo,
                      showRemoveCart ? _catCtrl.removeCartItem : null,
                    ),
                  ),
                ),
                ShopWiseTotalBill({
                  "totalMrp": orderPriceInfo.totalMrp,
                  "totalSp": orderPriceInfo.totalSp,
                }, false),
                actionBtn,
              ],
            ),
          )
        : Container();
  }
}
