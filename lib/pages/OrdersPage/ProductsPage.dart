import 'package:bazaar_bihar/models/ShopModels.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/components/FloatingCartButton.dart';
import 'package:bazaar_bihar/pages/OrdersPage/ProductCard.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage({Key? key}) : super(key: key);
  final ShopModel _shop = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print(Get.mediaQuery.size.height);
    print(Get.mediaQuery.size.width);
    return GetBuilder<GlobalController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(_shop.name),
        ),
        floatingActionButton: FloatingCartButton(),
        body: Container(
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.all(8),
          child: GridView.count(
            crossAxisCount: 1,
            crossAxisSpacing: 2.0,
            childAspectRatio: 1,
            children:
                _.productsList.map((product) => ProductCard(product)).toList(),
          ),
        ),
      ),
    );
  }
}
