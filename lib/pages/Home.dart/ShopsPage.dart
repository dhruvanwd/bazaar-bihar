import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orca_mob/GetxControllers/GlobalController.dart';
import 'package:orca_mob/components/FloatingCartButton.dart';
import 'package:orca_mob/pages/Home.dart/ShopsList.dart';

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
