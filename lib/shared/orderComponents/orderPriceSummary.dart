import '../Utils/utils.dart';
import '../models/OrderModel.dart';
import 'package:flutter/material.dart';

orderPriceSummary(OrderModel orderDetail) {
  return Container(
    child: ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      title: Text(
        'Total (SP): $rupeeSymbol${orderDetail.sp}',
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
      trailing: Text(
        "MRP: $rupeeSymbol${orderDetail.mrp} ",
        style: TextStyle(
          decoration: TextDecoration.lineThrough,
          color: Colors.orange,
        ),
      ),
      subtitle: Text(
        'Discount: ${calculateDiscount(orderDetail.mrp, orderDetail.sp)}%',
      ),
    ),
  );
}
