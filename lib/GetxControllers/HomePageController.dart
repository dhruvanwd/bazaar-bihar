import 'package:get/get.dart';
import 'package:orca_mob/pages/Home.dart/LandingPage.dart';
import 'package:orca_mob/pages/OrdersPage/OrdersPage.dart';

class HomePageController extends GetxController {
  static HomePageController get to => Get.find();
  var currentTabIndex = 0;

  setTabIndex(int indx) {
    currentTabIndex = indx;
    update();
  }

  get currentPage {
    if (currentTabIndex == 0) {
      return LandingPage();
    } else if (currentTabIndex == 1) {
      return OrdersPage();
    }
    return LandingPage();
  }
}
