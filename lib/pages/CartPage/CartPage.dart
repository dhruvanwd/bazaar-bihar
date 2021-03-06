import 'package:bazaar_bihar/pages/CartPage/ProductCartItem.dart';
import 'package:bazaar_bihar/shared/Utils/extensions.dart';
import 'package:bazaar_bihar/shared/components/CachedImageManager.dart';
import 'package:bazaar_bihar/shared/models/CartModel.dart';
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
            toolbarTextStyle: TextStyle(color: Colors.green),
            iconTheme: IconTheme.of(context).copyWith(color: Colors.purple),
            titleSpacing: 0.0,
            title: Card(
              color: Colors.cyan.shade300,
              child: Padding(
                padding: EdgeInsets.all(8),
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
