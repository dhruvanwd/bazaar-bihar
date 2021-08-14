import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orca_mob/GetxControllers/GlobalController.dart';
import 'package:orca_mob/GetxControllers/HomePageController.dart';

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
        body: GetBuilder<HomePageController>(
            builder: (homePageCtrl) => homePageCtrl.currentPage),
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.flip,
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.map, title: 'Orders'),
            TabItem(icon: Icons.people, title: 'Profile'),
          ],
          initialActiveIndex: 0, //optional, default as 0
          onTap: _.homePageCtrl.setTabIndex,
        ),
      ),
    );
  }
}
