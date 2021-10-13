import 'package:bazaar_bihar/GetxControllers/OrderController.dart';
import 'package:bazaar_bihar/shared/components/ShopUnavailable.dart';
import 'package:flutter/material.dart';
import 'package:bazaar_bihar/pages/OrdersPage/OrderCard.dart';
import 'package:get/get.dart';

class OrdersPage extends StatelessWidget {
  // TODO: add filters to orders.
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<OrderController>(
        builder: (_orderCtrl) => Container(
          height: Get.mediaQuery.size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.lightBlue.shade50,
                Colors.blueGrey.shade50,
              ],
            ),
          ),
          padding: EdgeInsets.only(bottom: 50),
          child: Column(
            children: _orderCtrl.orders.length > 0
                ? _orderCtrl.orders.map((order) => OrderCard(order)).toList()
                : [ShopUnavailable("No order till now !")],
          ),
        ),
      ),
    );
  }
}
