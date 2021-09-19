import 'package:bazaar_bihar/pages/CartPage/ShopWiseBill.dart';
import 'package:bazaar_bihar/shared/Utils/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

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
                    callBack != null
                        ? IconButton(
                            onPressed: () {
                              callBack(shopInfo['shopName']);
                            },
                            icon: Icon(
                              EvilIcons.close_o,
                              color: Colors.red,
                            ),
                          )
                        : Container()
                  ],
                ),
              ],
            ),
          ))
      .toList();

  return SingleChildScrollView(
    child: Column(
      children: []
        ..addAll(shopsWidget)
        ..addAll([Divider()]),
    ),
  );
}
