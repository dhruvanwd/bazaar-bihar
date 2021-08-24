import 'package:bazaar_bihar/GetxControllers/CartController.dart';
import 'package:bazaar_bihar/pages/CartPage/cartFooter.dart';
import 'package:bazaar_bihar/pages/CartPage/CartPage.dart';
import 'package:bazaar_bihar/pages/CartPage/emptyCart.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartCarousel extends StatelessWidget {
  CartCarousel({Key? key}) : super(key: key);
  final CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (_catCtrl) => Scaffold(
        persistentFooterButtons: cartFooter(_catCtrl),
        body: Center(
          child: _catCtrl.carts.length > 0
              ? CarouselSlider(
                  items: _catCtrl.carts.map((cart) => CartPage(cart)).toList(),
                  carouselController: buttonCarouselController,
                  options: CarouselOptions(
                    height: Get.mediaQuery.size.height,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    reverse: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                )
              : emptyCart(),
        ),
      ),
    );
  }
}
