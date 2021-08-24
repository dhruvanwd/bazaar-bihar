import 'package:bazaar_bihar/models/CartAddressModel.dart';
import 'package:get/get.dart';

class UserAddressesCtrl extends GetxController {
  static UserAddressesCtrl get to => Get.find();
  final List<CartAddressModel> cartAdresses = [];

  addNewAddress(CartAddressModel address) {
    cartAdresses.add(address);
    update();
  }
}
