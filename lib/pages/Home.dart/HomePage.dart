import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/CartController.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/GetxControllers/HomePageController.dart';
import 'package:bazaar_bihar/components/FloatingCartButton.dart';
import 'package:bazaar_bihar/pages/Home.dart/AppBarMenu.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class HomePage extends StatelessWidget {
  final globalController = Get.find<GlobalController>();
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
    final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

    return GetBuilder<HomePageController>(
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
              title: Text(_.appTitle),
              actions: [
                IconButton(
                  onPressed: globalController.logout,
                  icon: Icon(AntDesign.logout),
                )
              ],
            ),
            body: _.currentPage,
            floatingActionButton: GetBuilder<CartController>(
              builder: (_floatCtrl) => Visibility(
                visible: _floatCtrl.products.length != 0,
                child: FloatingCartButton(),
              ),
            ),
            bottomNavigationBar: ConvexAppBar(
              backgroundColor: Get.theme.primaryColor,
              style: TabStyle.flip,
              items: [
                TabItem(icon: Icons.home, title: 'Home'),
                TabItem(icon: Icons.receipt, title: 'Orders'),
                TabItem(icon: Icons.people, title: 'Profile'),
              ],
              initialActiveIndex: _.currentTabIndex,
              onTap: _.setTabIndex,
            ),
          ),
        ),
      ),
    );
  }
}
