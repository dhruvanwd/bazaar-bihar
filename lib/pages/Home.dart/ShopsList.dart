import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/models/ShopModels.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class ShopsList extends StatelessWidget {
  ShopsList(this.shopsList);
  final List<ShopModel> shopsList;
  final PageController _pageController = PageController();

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
        items: shopsList.length != 0
            ? shopsList
                .map(
                  (shop) => InkWell(
                    onTap: () {
                      GlobalController.to.fetchProductsByShopId(shop.id);
                      Get.toNamed(
                        '/products',
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.only(bottom: 16),
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              enlargeCenterPage: true,
                              viewportFraction: 1,
                              aspectRatio: 1,
                              height: 320,
                              enlargeStrategy: CenterPageEnlargeStrategy.scale,
                            ),
                            items: [
                              Image.asset(
                                'images/mart.jpg',
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                'images/makeup.jpg',
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                'images/mushrooms.jpg',
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          Container(
                            child: ListTile(
                              title: Text(shop.name),
                              trailing: Text('9:00 AM - 9:00 PM'),
                              subtitle: Text(shop.addressLine1),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
                .toList()
            : [
                Container(
                  child: Center(
                    child: Text("No shop found...."),
                  ),
                )
              ],
      ),
    );
  }
}
