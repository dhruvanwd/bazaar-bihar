import 'package:bazaar_bihar/shared/components/CarouselWithIndicator.dart';
import 'package:bazaar_bihar/shared/models/ShopModels.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:widget_marquee/widget_marquee.dart';
import 'package:division/division.dart';

class ShopCard extends StatelessWidget {
  final ShopModel shop;
  ShopCard(this.shop);

  final String weekDayNm = DateFormat('EEE').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    bool isShopOpen = shop.weekDays.contains(weekDayNm);
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              CarouselWithIndicator(shop.images, aspectRatio: 1.3),
              Container(
                child: ListTile(
                  title: Text(
                    shop.name,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Text(
                    '${shop.operatingTime["start"]} - ${shop.operatingTime["end"]}',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  subtitle: shop.addressLine1.length > 30
                      ? Marquee(
                          child: Text(shop.addressLine1),
                          delayDuration: Duration(seconds: 2),
                          gap: 40,
                        )
                      : Text(shop.addressLine1),
                ),
              )
            ],
          ),
          if (!isShopOpen)
            Positioned(
              top: 8,
              left: 8,
              child: Parent(
                style: ParentStyle()
                  ..background.color(Colors.white)
                  ..padding(all: 4, right: 8)
                  ..borderRadius(all: 8),
                child: Row(
                  children: [
                    Parent(
                      style: ParentStyle()..margin(right: 4),
                      child: Icon(
                        Icons.info,
                        color: Colors.blue,
                      ),
                    ),
                    Txt(
                      "Closed Today",
                      style: TxtStyle()
                        ..fontSize(12)
                        ..textColor(Colors.deepOrange),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
