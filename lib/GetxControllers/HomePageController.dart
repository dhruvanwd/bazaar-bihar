import 'package:bazaar_bihar/Home/LandingPage.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/pages/OrdersPage/OrdersPage.dart';
import 'package:bazaar_bihar/pages/profilePage/ProfilePage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomePageController extends GetxController {
  static HomePageController get to => Get.find();
  int currentTabIndex = 0;
  dynamic subscription;
  String appTitle = "Homepage";

  setTabIndex(int indx) {
    currentTabIndex = indx;
    if (currentTabIndex == 0) {
      appTitle = "Homepage";
    } else if (currentTabIndex == 1) {
      appTitle = "My orders";
    } else if (currentTabIndex == 2) {
      appTitle = "Profile";
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }

  get currentPage {
    if (currentTabIndex == 0) {
      return LandingPage();
    } else if (currentTabIndex == 1) {
      return OrdersPage();
    } else if (currentTabIndex == 2) {
      return ProfilePage();
    }
    return LandingPage();
  }
}
