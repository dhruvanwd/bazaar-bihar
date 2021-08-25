import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/models/CartAddressModel.dart';
import 'package:bazaar_bihar/models/CartModel.dart';
import 'package:get/get.dart';

class UserAddressesCtrl extends GetxController {
  static UserAddressesCtrl get to => Get.find();
  final List<CartAddressModel> cartAdresses = [];

  late CartAddressModel selectedAddres;

  updateOfflineAddressData() {
    final addressJsonList = cartAdresses.map((addr) => addr.toJson()).toList();
    GlobalController.to.updateStorage(EStorageKeys.CART_ADDRESS, {
      "addresses": addressJsonList,
      "selectedAddres": selectedAddres.toJson()
    });
    print("updateOfflineAddressData...........!");
  }

  void updateSelectedAddress(CartAddressModel address) {
    selectedAddres = address;
    updateOfflineAddressData();
    update();
  }

  addNewAddress(CartAddressModel address) {
    cartAdresses.add(address);
    Get.snackbar("Address added", '');
    selectedAddres = address;
    updateOfflineAddressData();
    Get.back();
    update();
  }

  restoreOfflineAddressData() {
    final Map? addrJson =
        GlobalController.to.getStroageJson(EStorageKeys.CART_ADDRESS);
    print("restoreOfflineAddressData...........!");
    print(addrJson);
    if (addrJson != null) {
      final List addrJsonList = List.from(addrJson['addresses']);
      selectedAddres = cartAddressModelFromJson(addrJson['selectedAddres']);
      addrJsonList.forEach((cartJson) =>
          {cartAdresses.add(CartAddressModel.fromJson(cartJson))});
    }
  }

  @override
  void onInit() {
    restoreOfflineAddressData();
    super.onInit();
  }
}
