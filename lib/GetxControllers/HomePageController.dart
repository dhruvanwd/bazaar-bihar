import 'package:get/get.dart';
import 'package:bazaar_bihar/pages/Home.dart/LandingPage.dart';
import 'package:bazaar_bihar/pages/OrdersPage/OrdersPage.dart';
import 'package:bazaar_bihar/pages/profilePage/ProfilePage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomePageController extends GetxController {
  static HomePageController get to => Get.find();
  int currentTabIndex = 0;
  bool showOfflineDialog = false;
  dynamic subscription;

  setTabIndex(int indx) {
    currentTabIndex = indx;
    update();
  }

  handleInternetStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      print("internet not connected");
      showOfflineDialog = true;
    } else {
      print("internet connected");
      showOfflineDialog = false;
    }
    update();
  }

  checkInternetStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    handleInternetStatus(connectivityResult);
  }

  @override
  void onInit() {
    checkInternetStatus();
    subscription =
        Connectivity().onConnectivityChanged.listen(handleInternetStatus);
    super.onInit();
  }

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
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
