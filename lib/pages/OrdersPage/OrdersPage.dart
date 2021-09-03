import 'package:bazaar_bihar/GetxControllers/OrderController.dart';
import 'package:bazaar_bihar/components/ShopUnavailable.dart';
import 'package:flutter/material.dart';
import 'package:bazaar_bihar/pages/OrdersPage/OrderCard.dart';
import 'package:get/get.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<OrderController>(
        builder: (_orderCtrl) => Container(
          margin: EdgeInsets.only(bottom: 50),
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
