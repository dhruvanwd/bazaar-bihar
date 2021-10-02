import 'package:bazaar_bihar/Widgets/FloatingCartButton.dart';
import 'package:bazaar_bihar/shared/components/ShopUnavailable.dart';
import 'package:bazaar_bihar/shared/models/ShopModels.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
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
          height: Get.mediaQuery.size.height,
          margin: EdgeInsets.only(top: 5, bottom: 10),
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
              child: Column(
            children: _.productsList.length > 0
                ? _.productsList.map((product) => ProductCard(product)).toList()
                : [ShopUnavailable("No product found....")],
          )),
        ),
      ),
    );
  }
}
