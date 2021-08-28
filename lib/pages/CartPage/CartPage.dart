import 'package:bazaar_bihar/components/CachedImageManager.dart';
import 'package:bazaar_bihar/models/CartModel.dart';
import 'package:bazaar_bihar/pages/CartPage/ProductCartItem.dart';
import 'package:flutter/material.dart';
import 'package:bazaar_bihar/Utils/extensions.dart' show CapExtension;

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
            toolbarTextStyle: TextStyle(color: Colors.green),
            title: Card(
              color: Colors.white60,
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Text(
                  cart.shop.name.inCaps,
                  style: TextStyle(color: Colors.purple),
                ),
              ),
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
              (content, index) =>
                  ProductCartItem(cart.products[index], cart.shop),
              childCount: cart.products.length,
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(bottom: 200))
        ],
      ),
    );
  }
}
