import 'package:bazaar_bihar/components/CachedImageManager.dart';
import 'package:bazaar_bihar/models/CartModel.dart';
import 'package:bazaar_bihar/pages/CartPage/ProductCartItem.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final CartModel cart;
  CartPage(this.cart);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            stretch: true,
            title: Text(
              cart.shop.name,
              style: TextStyle(color: Colors.brown),
            ),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.all(0),
              title: SingleChildScrollView(
                padding: EdgeInsets.all(0),
                child: CachedImageMananger(
                  cart.shop.images[0],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (content, index) => ProductCartItem(
                cart.products[index],
              ),
              childCount: cart.products.length,
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(bottom: 200))
        ],
      ),
    );
  }
}