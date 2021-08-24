import 'package:bazaar_bihar/models/CartAddressModel.dart';
import 'package:get/get.dart';

class UserAddressesCtrl extends GetxController {
  static UserAddressesCtrl get to => Get.find();
  final List<CartAddressModel> cartAdresses = [];

  late CartAddressModel selectedAddres;

  void updateSelectedAddress(CartAddressModel address) {
    selectedAddres = address;
    update();
  }

  addNewAddress(CartAddressModel address) {
    cartAdresses.add(address);
    Get.snackbar("Address added", '');
    selectedAddres = address;
    Get.back();
    update();
  }
}
