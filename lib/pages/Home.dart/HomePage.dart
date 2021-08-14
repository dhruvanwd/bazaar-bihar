import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orca_mob/GetxControllers/GlobalController.dart';
import 'package:orca_mob/pages/Home.dart/ShopsList.dart';
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
          height: Get.mediaQuery.size.height - 40,
          child: Column(
            children: [
              ShopByCategory(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Suggested Shops",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Expanded(child: ShopsList())
            ],
          ),
        ),
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.flip,
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.map, title: 'Orders'),
            TabItem(icon: Icons.people, title: 'Profile'),
          ],
          initialActiveIndex: 0, //optional, default as 0
          onTap: (int i) => print('click index=$i'),
        ),
      ),
    );
  }
}
