import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/components/FloatingCartButton.dart';
import 'package:bazaar_bihar/pages/Home.dart/ShopsList.dart';

class ShopsPage extends StatelessWidget {
  ShopsPage({key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shops"),
      ),
      floatingActionButton: FloatingCartButton(),
      body: GetBuilder<GlobalController>(
          builder: (_) => ShopsList(_.shopsListByCatId)),
    );
  }
}
