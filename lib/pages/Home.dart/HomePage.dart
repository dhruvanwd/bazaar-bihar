import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orca_mob/GetxControllers/GlobalController.dart';

import 'ShopByCategory.dart';

class HomePage extends StatelessWidget {
  final globalController = Get.find<GlobalController>();
  HomePage({Key? key}) {
    globalController.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text("Homepage"),
          actions: [
            IconButton(
              onPressed: _.logout,
              icon: Icon(
                Icons.logout,
              ),
            )
          ],
        ),
        body: Container(
          child: Column(
            children: [ShopByCategory()],
          ),
        ),
      ),
    );
  }
}
