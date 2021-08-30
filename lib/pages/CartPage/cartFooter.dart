import 'package:bazaar_bihar/GetxControllers/CartController.dart';
import 'package:bazaar_bihar/models/PaymentInfoModal.dart';
import 'package:bazaar_bihar/pages/CartPage/CollapsableCartFooter.dart';
import 'package:bazaar_bihar/pages/CartPage/ShopWiseBill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/Utils/extensions.dart' show CapExtension;

genShopDetail(List<Map> shopsInfo, dynamic callBack) {
  final shopsWidget = shopsInfo
      .map((shopInfo) => Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                    (shopInfo['shopName'] as String).inCaps,
                    style: Get.theme.textTheme.subtitle1!
                        .copyWith(color: Colors.purple),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ShopWiseTotalBill({
                        "totalMrp": shopInfo['mrp'],
                        "totalSp": shopInfo['sp']
                      }, true),
                    ),
                    IconButton(
                      onPressed: () {
                        callBack(shopInfo['shopName']);
                      },
                      icon: Icon(
                        EvilIcons.close_o,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ))
      .toList();

  return SingleChildScrollView(
    child: Column(
      children: []..addAll(shopsWidget)..addAll([Divider()]),
    ),
  );
}

class CartFooter extends StatelessWidget {
  final actionBtn;
  CartFooter(this.actionBtn);
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
                        orderPriceInfo.shopWiseInfo, _catCtrl.removeCartItem),
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
