import 'package:bazaar_bihar/shared/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/orderComponents/orderUserNameDateCount.dart';
import '../../shared/orderComponents/orderPriceSummary.dart';
import '../../shared/models/OrderModel.dart';
import '../../shared/orderComponents/ProductCard.dart';

class DetailedOrder extends StatelessWidget {
  final OrderModel orderDetail;
  DetailedOrder(this.orderDetail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Order Details"),
        ),
        body: Container(
          height: Get.mediaQuery.size.height,
          decoration: BoxDecoration(gradient: lightGradient),
          child: Column(
            children: [
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 0, bottom: 8),
                      child: orderUserNameDateCount(orderDetail),
                    ),
                    orderPriceSummary(orderDetail),
                    // Padding(
                    //   padding: EdgeInsets.only(
                    //     bottom: 4,
                    //     left: 16,
                    //     right: 16,
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       TextButton(
                    //         onPressed: () {
                    //           Get.dialog(Container(
                    //             height: 400,
                    //             color: Colors.white,
                    //             child: Column(
                    //               children: [],
                    //             ),
                    //           ));
                    //         },
                    //         child: Text(
                    //           "Rate this order",
                    //           style:
                    //               TextStyle(color: Colors.purple, fontSize: 13),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        ...orderDetail.products
                            .map((product) => ProductCard(product))
                            .toList(),
                        Padding(padding: EdgeInsets.symmetric(vertical: 16))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
