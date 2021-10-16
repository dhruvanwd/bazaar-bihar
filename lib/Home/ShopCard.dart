import 'package:bazaar_bihar/shared/components/CarouselWithIndicator.dart';
import 'package:bazaar_bihar/shared/models/ShopModels.dart';
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
          CarouselWithIndicator(shop.images, aspectRatio: 1.3),
          Container(
            child: ListTile(
              title: Text(shop.name),
              trailing: Text(
                  '${shop.operatingTime["start"]} - ${shop.operatingTime["end"]}'),
              subtitle: Text(shop.addressLine1),
            ),
          )
        ],
      ),
    );
  }
}
