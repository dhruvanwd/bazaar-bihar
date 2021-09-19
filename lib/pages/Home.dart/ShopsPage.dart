import 'package:bazaar_bihar/Widgets/FloatingCartButton.dart';
import 'package:bazaar_bihar/shared/models/CategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/pages/Home.dart/ShopsList.dart';

class ShopsPage extends StatelessWidget {
  ShopsPage({key}) : super(key: key);
  final CategoryModel category = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${category.name} Shops"),
      ),
      floatingActionButton: FloatingCartButton(),
      body: GetBuilder<GlobalController>(
          builder: (_) => ShopsList(_.shopsListByCatId)),
    );
  }
}
