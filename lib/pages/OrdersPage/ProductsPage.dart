import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/components/FloatingCartButton.dart';
import 'package:bazaar_bihar/pages/OrdersPage/ProductCard.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('Shop Name'),
        ),
        floatingActionButton: FloatingCartButton(),
        body: Container(
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.all(8),
          child: GridView.count(
            crossAxisCount: 1,
            crossAxisSpacing: 8.0,
            childAspectRatio: 1.1,
            children:
                _.productsList.map((product) => ProductCard(product)).toList(),
          ),
        ),
      ),
    );
  }
}
