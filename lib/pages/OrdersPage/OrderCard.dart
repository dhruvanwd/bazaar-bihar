import 'package:bazaar_bihar/shared/models/OrderModel.dart';
import 'package:bazaar_bihar/shared/orderComponents/DetailedOrder.dart';
import 'package:bazaar_bihar/shared/orderComponents/orderPriceSummary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderCard extends StatelessWidget {
  final OrderModel orderDetail;
  OrderCard(this.orderDetail);

  @override
  Widget build(BuildContext context) {
    print(orderDetail);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      child: InkWell(
        onTap: () {
          Get.to(DetailedOrder(orderDetail));
        },
        child: Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  top: 8,
                  right: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(orderDetail.shop.name),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 8,
                      ),
                    ),
                    Text(
                      orderDetail.status,
                      style: TextStyle(color: Colors.purple, fontSize: 16),
                    )
                  ],
                ),
              ),
              orderPriceSummary(orderDetail),
            ],
          ),
        ),
      ),
    );
  }
}
