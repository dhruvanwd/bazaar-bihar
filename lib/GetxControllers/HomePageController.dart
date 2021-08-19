import 'package:get/get.dart';
import 'package:bazaar_bihar/pages/Home.dart/LandingPage.dart';
import 'package:bazaar_bihar/pages/OrdersPage/OrdersPage.dart';
import 'package:bazaar_bihar/pages/profilePage/ProfilePage.dart';

class HomePageController extends GetxController {
  static HomePageController get to => Get.find();
  int currentTabIndex = 0;

  setTabIndex(int indx) {
    currentTabIndex = indx;
    update();
  }

  @override
  void onInit() {
    print('initializing HomePageController...............!');
    super.onInit();
  }

  var appTitle = "Homepage";

  get currentPage {
    if (currentTabIndex == 0) {
      appTitle = "Homepage";
      return LandingPage();
    } else if (currentTabIndex == 1) {
      appTitle = "My orders";
      return OrdersPage();
    } else if (currentTabIndex == 2) {
      appTitle = "Profile";
      return ProfilePage();
    }
    appTitle = "Homepage";
    return LandingPage();
  }
}
