import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/Utils/ApiService.dart';
import 'package:bazaar_bihar/Utils/RequestBody.dart';
import 'package:bazaar_bihar/models/CartAddressModel.dart';
import 'package:get/get.dart';

class CartAddressController extends GetxController {
  static CartAddressController get to => Get.find();
  final List<CartAddressModel> cartAdresses = [];
  final ApiRequest _apiInstance = ApiRequest();

  CartAddressModel? selectedAddres;

  updateOfflineAddressData() {
    final addressJsonList = cartAdresses.map((addr) => addr.toJson()).toList();
    GlobalController.to.updateStorage(EStorageKeys.CART_ADDRESS, {
      "addresses": addressJsonList,
      "selectedAddres": selectedAddres?.toJson()
    });
  }

  void updateSelectedAddress(CartAddressModel address) {
    selectedAddres = address;
    updateOfflineAddressData();
    update();
  }

  Future<CartAddressModel> createNewAddress(CartAddressModel address) async {
    final Map jsonCartAddress = address.toJson();
    final profile = GlobalController.to.getStroageJson(EStorageKeys.PROFILE);
    jsonCartAddress["ownerId"] = profile['_id'];
    jsonCartAddress.remove("_id");
    print("after removing id");
    print(jsonCartAddress);
    final resp = await _apiInstance.storeData(RequestBody(
        amendType: "insertOne",
        collectionName: "cart_addresses",
        payload: [jsonCartAddress]));
    print(resp.data['ops'][0]);
    Get.back();
    return cartAddressModelFromJson(resp.data['ops'][0]);
  }

  addNewAddress(CartAddressModel addr) async {
    final address = await createNewAddress(addr);
    cartAdresses.add(address);
    Get.snackbar("Address added", '');
    selectedAddres = address;
    updateOfflineAddressData();
    update();
  }

  deleteUserAddress(CartAddressModel addr) {
    try {
      cartAdresses.removeWhere((cartAddr) => cartAddr.id == addr.id);
      if (selectedAddres == addr) {
        selectedAddres = null;
      }
      updateOfflineAddressData();
      update();
    } catch (e) {
      print("Invalid address. couldn\t delete");
    }
  }

  restoreOfflineAddressData() {
    final Map? addrJson =
        GlobalController.to.getStroageJson(EStorageKeys.CART_ADDRESS);
    print("restoreOfflineAddressData...........!");
    if (addrJson != null) {
      final List addrJsonList = List.from(addrJson['addresses']);
      selectedAddres = cartAddressModelFromJson(addrJson['selectedAddres']);
      addrJsonList.forEach((cartJson) =>
          {cartAdresses.add(CartAddressModel.fromJson(cartJson))});
    }
  }

  fetchCartAddresses() async {
    if (cartAdresses.length != 0) return;
    final profile = GlobalController.to.getStroageJson(EStorageKeys.PROFILE);
    final resp = await _apiInstance.fetchData(RequestBody(
        amendType: 'findOne',
        collectionName: 'cart_addresses',
        payload: {"ownerId": profile['_id']}));
    print("cart addresses..............!");
    List addresses = resp.data;
    addresses.forEach((addr) {
      cartAdresses.add(cartAddressModelFromJson(addr));
    });
    updateOfflineAddressData();
    update();
  }

  @override
  void onInit() {
    restoreOfflineAddressData();
    fetchCartAddresses();
    super.onInit();
  }
}
