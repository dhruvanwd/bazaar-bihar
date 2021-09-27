import 'package:bazaar_bihar/pages/Home/CategoryCard.dart';
import 'package:bazaar_bihar/pages/Home/CategoryChip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';

class ShopByCategory extends StatelessWidget {
  ShopByCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalController>(
      builder: (_) => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
            child: Container(
              width: Get.mediaQuery.size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(
                      "Shop by category",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                            padding: EdgeInsetsDirectional.all(2),
                            onPressed: () {
                              _.updateCategoryViewer(ECategoryViewer.CARD);
                            },
                            color: _.categoryViewer == ECategoryViewer.CARD
                                ? Get.theme.primaryColor
                                : Colors.grey,
                            icon: Icon(
                              FontAwesome.align_center,
                            )),
                        IconButton(
                          padding: EdgeInsetsDirectional.all(2),
                          color: _.categoryViewer == ECategoryViewer.CHIP
                              ? Get.theme.primaryColor
                              : Colors.grey,
                          onPressed: () {
                            _.updateCategoryViewer(ECategoryViewer.CHIP);
                          },
                          icon: Icon(
                            FontAwesome.th_large,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: _.categoryViewer == ECategoryViewer.CHIP ? 40 : 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _.categories
                  .map(
                    (cat) => _.categoryViewer == ECategoryViewer.CHIP
                        ? CategoryChip(cat)
                        : CategoryCard(cat),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
