import 'package:bazaar_bihar/Home/ShopCard.dart';
import 'package:bazaar_bihar/shared/components/ShopUnavailable.dart';
import 'package:bazaar_bihar/shared/models/ShopModels.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class ShopsList extends StatelessWidget {
  ShopsList(this.shopsList);
  final List<ShopModel> shopsList;
  final PageController _pageController = PageController();
  final GlobalController _globalController = GlobalController.to;
  final screenWidth = Get.mediaQuery.size.width;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      width: Get.size.width,
      child: StackedCardCarousel(
        pageController: _pageController,
        type: StackedCardCarouselType.fadeOutStack,
        initialOffset: 16,
        spaceBetweenItems: screenWidth < 365 ? 320 : 370,
        items: shopsList.length != 0
            ? shopsList
                .map(
                  (shop) => InkWell(
                    onTap: () {
                      _globalController.clearProductsList();
                      _globalController.fetchProductsByShopId(shop.id);
                      Get.toNamed('/products', arguments: shop);
                    },
                    child: ShopCard(shop),
                  ),
                )
                .toList()
            : [ShopUnavailable("No shop found....")],
      ),
    );
  }
}
