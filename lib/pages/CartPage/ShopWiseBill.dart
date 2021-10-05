import 'package:flutter/material.dart';

class ShopWiseTotalBill extends StatelessWidget {
  final Map shopData;
  final bool isShop;
  ShopWiseTotalBill(this.shopData, this.isShop);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Text(
            "${isShop ? '' : 'Total '}MRP: ₹${shopData['totalMrp']}",
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.red.shade500,
            ),
          ),
        ),
        Text(
          "${isShop ? 'SP: ' : 'Payable: '} ₹${shopData['totalSp']}",
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Colors.purple,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
