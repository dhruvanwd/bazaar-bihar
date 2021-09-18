import 'package:bazaar_bihar/components/ShopUnavailable.dart';
import 'package:bazaar_bihar/models/ShopModels.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/components/FloatingCartButton.dart';
import 'package:bazaar_bihar/pages/OrdersPage/ProductCard.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage({Key? key}) : super(key: key);
  final ShopModel _shop = Get.arguments;
  final screenWidth = Get.mediaQuery.size.width;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(_shop.name),
        ),
        floatingActionButton: FloatingCartButton(),
        body: Container(
          margin: EdgeInsets.only(top: 5, bottom: 10),
          padding: EdgeInsets.all(8),
          child: GridView.count(
            crossAxisCount: 1,
            crossAxisSpacing: 2.0,
            childAspectRatio: screenWidth < 365 ? 1 : 1.1,
            children: _.productsList.length > 0
                ? _.productsList.map((product) => ProductCard(product)).toList()
                : [ShopUnavailable("No product found....")],
          ),
        ),
      ),
    );
  }
}
