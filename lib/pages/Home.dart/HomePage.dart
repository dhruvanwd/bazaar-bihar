import 'package:bazaar_bihar/components/OfflineDialog.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/CartController.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/GetxControllers/HomePageController.dart';
import 'package:bazaar_bihar/components/FloatingCartButton.dart';
import 'package:bazaar_bihar/pages/Home.dart/AppBarMenu.dart';
import 'package:new_version/new_version.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class HomePage extends StatelessWidget {
  final _globalController = Get.find<GlobalController>();
  final newVersion = NewVersion();
  HomePage() {
    if (_globalController.shopsList.length == 0) {
      _globalController.fetchShops(null);
    }
  }

  showOfflineDialog() async {
    await Future.delayed(Duration(seconds: 2));
    Get.defaultDialog(
      content: OfflineDialog(),
      title: "You are offline..!",
      titlePadding: EdgeInsets.all(16),
      confirm: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text("Okay"),
      ),
      titleStyle: TextStyle(color: Colors.brown),
    );
  }

  checkUpdate(BuildContext context) {
    try {
      newVersion.getVersionStatus().then((status) {
        print("--------android status update----------");
        print(status!.localVersion);
        print(status.storeVersion);
        print(status.releaseNotes);
        print(status.canUpdate);
        if (status.storeVersion != "Varies with device")
          newVersion.showAlertIfNecessary(context: context);
      });
    } catch (e) {
      print(e);
    }
  }

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

  toggleDrawer() {
    final _state = _sideMenuKey.currentState;
    if (_state!.isOpened)
      _state.closeSideMenu(); // close side menu
    else
      _state.openSideMenu(); // open side menu
  }

  @override
  Widget build(BuildContext context) {
    checkUpdate(context);
    return GetBuilder<HomePageController>(
      builder: (_) {
        if (_.showOfflineDialog) {
          showOfflineDialog();
        }
        return SideMenu(
          key: _endSideMenuKey,
          inverse: true, // end side menu
          background: Colors.blueGrey.shade700,
          type: SideMenuType.slideNRotate,
          menu: AppBarMenu(toggleDrawer),
          radius: BorderRadius.circular(8),
          child: SideMenu(
            key: _sideMenuKey,
            menu: AppBarMenu(toggleDrawer),
            type: SideMenuType.slideNRotate,
            radius: BorderRadius.circular(8),
            background: Colors.blueGrey.shade700,
            child: Scaffold(
              appBar: AppBar(
                leading:
                    IconButton(icon: Icon(Icons.menu), onPressed: toggleDrawer),
                title: Text(_.appTitle),
                actions: [
                  IconButton(
                    onPressed: _globalController.logout,
                    icon: Icon(AntDesign.logout),
                  )
                ],
              ),
              body: _.currentPage,
              floatingActionButton: GetBuilder<CartController>(
                builder: (_floatCtrl) => Visibility(
                  visible: _floatCtrl.carts.length != 0,
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
        );
      },
    );
  }
}
