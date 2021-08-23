import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/models/CartModel.dart';
import 'package:bazaar_bihar/pages/CartPage/ProductCartItem.dart';
import 'package:bazaar_bihar/pages/Home.dart/ShopCard.dart';
import 'package:bazaar_bihar/pages/OrdersPage/CarouselWithIndicator.dart';
import 'package:bazaar_bihar/pages/OrdersPage/ProductCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  final CartModel cart;
  final _ = GlobalController.to;
  CartPage(this.cart);
// cart.shop.images[0]
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            title: Text(cart.shop.name),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.all(0),
              title: SingleChildScrollView(
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      _.createImageUrl(
                        cart.shop.images[0],
                      ),
                    ),
                  )),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (content, index) => ProductCartItem(
                      cart.products[index],
                    ),
                childCount: cart.products.length),
          )
        ],
      ),
    );
  }
}
