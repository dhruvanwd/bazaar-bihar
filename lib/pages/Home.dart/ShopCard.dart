import 'package:bazaar_bihar/models/ShopModels.dart';
import 'package:bazaar_bihar/pages/OrdersPage/CarouselWithIndicator.dart';
import 'package:flutter/material.dart';

class ShopCard extends StatelessWidget {
  final ShopModel shop;
  ShopCard(this.shop);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          CarouselWithIndicator(shop.images),
          Container(
            child: ListTile(
              title: Text(shop.name),
              trailing: Text('9:00 AM - 9:00 PM'),
              subtitle: Text(shop.addressLine1),
            ),
          )
        ],
      ),
    );
  }
}
