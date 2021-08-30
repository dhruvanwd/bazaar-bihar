import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:bazaar_bihar/Utils/ApiService.dart';
import 'package:bazaar_bihar/Utils/RequestBody.dart';
import 'package:bazaar_bihar/models/CategoryModel.dart';
import 'package:bazaar_bihar/models/ImagesModel.dart';
import 'package:bazaar_bihar/models/ProductsModel.dart';
import 'package:bazaar_bihar/models/ShopModels.dart';
import 'package:bazaar_bihar/pages/login-signup/LoginPage.dart';
import 'package:intl/intl.dart';

enum EStorageKeys { PROFILE, SETTINGS, CART, CART_ADDRESS }

class GlobalController extends GetxController {
  static GlobalController get to => Get.find();
  var dateFormat = DateFormat("yy-MM-dd hh:mm:ss aaa");
  ThemeMode get themeMode => ThemeMode.system;
  final ApiRequest apiRequestInstance = ApiRequest();

  final _localStorage = GetStorage();

  getKeyFromEnum(EStorageKeys key) {
    if (key == EStorageKeys.PROFILE) {
      return "profile";
    } else if (key == EStorageKeys.SETTINGS) {
      return 'settings';
    } else if (key == EStorageKeys.CART) {
      return 'cart';
    } else if (key == EStorageKeys.CART_ADDRESS) {
      return 'addresses';
    }
  }

  updateTheme() {}

  logout() {
    Get.defaultDialog(
      title: "Logout ?",
      titlePadding: EdgeInsets.only(top: 20, bottom: 10),
      middleText: "Are you sure. you want to logout?",
      backgroundColor: Colors.grey.shade100,
      titleStyle: TextStyle(color: Colors.brown),
      confirm: TextButton(
        onPressed: () {
          _localStorage.erase();
          Get.offAll(LoginPage());
          Get.back();
        },
        child: Text(
          "yes, Logout",
          style: TextStyle(color: Colors.deepOrange),
        ),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text(
          "Close",
          style: TextStyle(color: Colors.green),
        ),
      ),
    );
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
    try {
      final resp = await apiRequestInstance.fetchData(
          RequestBody(amendType: '', collectionName: 'categories', payload: {
        "name": {
          "\$regex": '',
          "\$options": 'i',
        },
      }));
      categories = categoryModelFromMap(resp.data);
      // closeLoader();
      update();
    } catch (e) {
      print(e);
    }
  }

  createImageUrl(ImageModel image) =>
      'https://bazaar-bihar.s3.ap-south-1.amazonaws.com/' + image.filename;

  @override
  void onInit() {
    // checkNetworkConnectivity();
    fetchCategories();
    super.onInit();
  }

  List<ShopModel> shopsList = [];
  List<ShopModel> shopsListByCatId = [];

  clearCurrentShop() {
    shopsListByCatId = [];
    update();
  }

  fetchShops(String? categoryId) async {
    try {
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
      final resp = await apiRequestInstance.fetchData(RequestBody(
          amendType: '', collectionName: 'shops', payload: payload));
      if (categoryId == null) {
        shopsList = shopModelFromJson(resp.data);
      } else {
        shopsListByCatId = shopModelFromJson(resp.data);
      }
      update();
    } catch (e) {
      print(e);
    }
  }

  clearProductsList() {
    productsList = [];
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
