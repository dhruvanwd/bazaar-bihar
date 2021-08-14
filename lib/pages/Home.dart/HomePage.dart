import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:orca_mob/GetxControllers/GlobalController.dart';
import 'package:orca_mob/GetxControllers/HomePageController.dart';
import 'package:orca_mob/pages/Home.dart/AppBarMenu.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class HomePage extends StatelessWidget {
  final globalController = Get.find<GlobalController>();
  HomePage({Key? key}) {
    globalController.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
    final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

    return GetBuilder<GlobalController>(
      builder: (_) => SideMenu(
        key: _endSideMenuKey,
        inverse: true, // end side menu
        background: Colors.green[700],
        type: SideMenuType.slideNRotate,
        menu: AppBarMenu(),
        radius: BorderRadius.circular(8),
        child: SideMenu(
          key: _sideMenuKey,
          menu: AppBarMenu(),
          type: SideMenuType.slideNRotate,
          radius: BorderRadius.circular(8),
          background: Colors.green[700],
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  final _state = _sideMenuKey.currentState;
                  if (_state!.isOpened)
                    _state.closeSideMenu(); // close side menu
                  else
                    _state.openSideMenu(); // open side menu
                },
              ),
              title: GetBuilder<HomePageController>(
                builder: (_homeCtrl) => Text(_homeCtrl.appTitle),
              ),
              actions: [
                IconButton(
                  onPressed: _.logout,
                  icon: Icon(AntDesign.logout),
                )
              ],
            ),
            body: GetBuilder<HomePageController>(
                builder: (homePageCtrl) => homePageCtrl.currentPage),
            bottomNavigationBar: ConvexAppBar(
              style: TabStyle.flip,
              items: [
                TabItem(icon: Icons.home, title: 'Home'),
                TabItem(icon: Icons.receipt, title: 'Orders'),
                TabItem(icon: Icons.people, title: 'Profile'),
              ],
              initialActiveIndex: 0, //optional, default as 0
              onTap: _.homePageCtrl.setTabIndex,
            ),
          ),
        ),
      ),
    );
  }
}
