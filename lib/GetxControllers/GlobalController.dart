import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:bazaar_bihar/GetxControllers/CartController.dart';
import 'package:bazaar_bihar/GetxControllers/HomePageController.dart';
import 'package:bazaar_bihar/Utils/ApiService.dart';
import 'package:bazaar_bihar/Utils/RequestBody.dart';
import 'package:bazaar_bihar/models/CategoryModel.dart';
import 'package:bazaar_bihar/models/ImagesModel.dart';
import 'package:bazaar_bihar/models/ProductsModel.dart';
import 'package:bazaar_bihar/models/ShopModels.dart';
import 'package:bazaar_bihar/pages/login-signup/LoginPage.dart';
import 'package:connectivity/connectivity.dart';

enum EStorageKeys {
  PROFILE,
  SETTINGS,
}

class GlobalController extends GetxController {
  static GlobalController get to => Get.find();
  ThemeMode get themeMode => ThemeMode.system;
  final ApiRequest apiRequestInstance =
      ApiRequest(baseUrl: 'http://52.14.49.133:8000');

  final _localStorage = GetStorage();

  getKeyFromEnum(EStorageKeys key) {
    if (key == EStorageKeys.PROFILE) {
      return "profile";
    } else if (key == EStorageKeys.SETTINGS) {
      return 'settings';
    }
  }

  updateTheme() {}

  logout() {
    _localStorage.erase();
    Get.off(LoginPage());
  }

  get isUserLoggedIn {
    try {
      return getStroageJson(EStorageKeys.PROFILE) != null;
    } catch (e) {
      return false;
    }
  }

  updateStorage(EStorageKeys key, dynamic data) {
    try {
      String keyName = getKeyFromEnum(key);
      final jsonEncoder = JsonEncoder();
      _localStorage.write(keyName, jsonEncoder.convert(data));
    } catch (e) {
      print(e);
    }
  }

  getStroageJson(EStorageKeys key) {
    try {
      String keyName = getKeyFromEnum(key);
      String rawJson = _localStorage.read(keyName);
      Map<String, dynamic> jsonData =
          Map<String, dynamic>.from(jsonDecode(rawJson));
      return jsonData;
    } catch (e) {
      print(e);
    }
  }

  // ------categories----------

  List<CategoryModel> categories = [];

  fetchCategories() async {
    final resp = await apiRequestInstance.fetchData(
        RequestBody(amendType: '', collectionName: 'categories', payload: {
      "name": {
        "\$regex": '',
        "\$options": 'i',
      },
    }));
    categories = categoryModelFromMap(resp.data);
    update();
  }

  createImageUrl(ImageModel image) =>
      'https://bazaar-bihar.s3.ap-south-1.amazonaws.com/' + image.filename;

  checkNetworkConnectivity() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar("Offline", "Check network connection");
    }
  }

  @override
  void onInit() {
    Get.put(HomePageController());
    Get.put(CartController());
    checkNetworkConnectivity();
    fetchCategories();
    super.onInit();
  }

  List<ShopModel> shopsList = [];
  List<ShopModel> shopsListByCatId = [];

  fetchShops(String? categoryId) async {
    final userProfile = getStroageJson(EStorageKeys.PROFILE);
    final Map<String, dynamic> payload = {
      "name": {
        "\$regex": '',
        "\$options": 'i',
      },
      "state": {
        "\$regex": userProfile['state'],
        "\$options": 'i',
      },
      "city": {
        "\$regex": userProfile['city'],
        "\$options": 'i',
      }
    };

    if (categoryId != null) {
      payload.assign("categoryId", categoryId);
    }
    final resp = await apiRequestInstance.fetchData(
        RequestBody(amendType: '', collectionName: 'shops', payload: payload));
    if (categoryId == null) {
      shopsList = shopModelFromJson(resp.data);
    } else {
      shopsListByCatId = shopModelFromJson(resp.data);
    }
    update();
  }

  List<ProductModel> productsList = [];
  fetchProductsByShopId(String shopId) async {
    final Map<String, dynamic> payload = {"shopId": shopId};
    final resp = await apiRequestInstance.fetchData(RequestBody(
        amendType: '', collectionName: 'products', payload: payload));
    productsList = productModelFromMap(resp.data);
    update();
  }
}
