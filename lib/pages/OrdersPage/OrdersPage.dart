import 'package:bazaar_bihar/GetxControllers/OrderController.dart';
import 'package:flutter/material.dart';
import 'package:bazaar_bihar/pages/OrdersPage/OrderCard.dart';
import 'package:get/get.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: GetBuilder<OrderController>(
      builder: (_orderCtrl) => Column(
        children: _orderCtrl.orders.map((order) => OrderCard(order)).toList(),
      ),
    ));
  }
}
