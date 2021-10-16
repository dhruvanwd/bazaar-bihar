import 'package:bazaar_bihar/GetxControllers/CartController.dart';
import 'package:bazaar_bihar/GetxControllers/OrderController.dart';
import 'package:bazaar_bihar/GetxControllers/PaymentController.dart';
import 'package:bazaar_bihar/Home/AppBarMenu.dart';
import 'package:bazaar_bihar/Widgets/FloatingCartButton.dart';
import 'package:bazaar_bihar/shared/ImageCropper/ImageCropperCtrl.dart';
import 'package:bazaar_bihar/shared/components/AppExitPopup.dart';
import 'package:bazaar_bihar/shared/components/OfflineDialog.dart';
import 'package:bazaar_bihar/shared/login-signup/VerifyMobile.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/GetxControllers/HomePageController.dart';
import 'package:new_version/new_version.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

// TODO:
// 1. add theming.
// 2.add internationalization.
// 5. add a simple wallet.
// 6. add faq section.
class HomePage extends StatelessWidget {
  final newVersion = NewVersion();

  verifyMobileDialog() async {
    await Future.delayed(Duration(seconds: 2));
    final _glblCtrl = Get.find<GlobalController>();
    if (_glblCtrl.userProfile?.mobile == "" ||
        _glblCtrl.userProfile?.mobile == null ||
        _glblCtrl.userProfile?.mobileVerified != true) {
      Get.dialog(
        VerifyMobile(),
        useSafeArea: true,
      );
    } else {
      print("${_glblCtrl.userProfile?.mobile} skipping verify mobile");
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
    try {
      Get.put(GlobalController());
      Get.put(CartController());
      Get.put(OrderController());
      Get.put(PaymentController());
      Get.put(ImageCropperController());
      verifyMobileDialog();
    } catch (e) {
      print(e);
    }

    return GetBuilder<HomePageController>(
      init: HomePageController(),
      builder: (_) {
        if (_.showOfflineDialog) {
          showOfflineDialog();
        }

        return WillPopScope(
          child: SideMenu(
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
                  leading: IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.menu),
                      onPressed: toggleDrawer),
                  title: Text(_.appTitle),
                ),
                body: _.currentPage,
                floatingActionButton: FloatingCartButton(),
                bottomNavigationBar: ConvexAppBar(
                  backgroundColor: Colors.cyan.withOpacity(0.5),
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
          onWillPop: () => showExitPopup(context),
        );
      },
    );
  }
}
