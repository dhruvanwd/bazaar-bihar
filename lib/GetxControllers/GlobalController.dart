import 'dart:convert';
import 'package:bazaar_bihar/components/customAnimation.dart';
import 'package:bazaar_bihar/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:bazaar_bihar/Utils/ApiService.dart';
import 'package:bazaar_bihar/Utils/RequestBody.dart';
import 'package:bazaar_bihar/models/CategoryModel.dart';
import 'package:bazaar_bihar/models/ImagesModel.dart';
import 'package:bazaar_bihar/models/ProductsModel.dart';
import 'package:bazaar_bihar/models/ShopModels.dart';
import 'package:bazaar_bihar/pages/login-signup/LoginPage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

enum EStorageKeys { PROFILE, SETTINGS, CART, CART_ADDRESS }

class GlobalController extends GetxController {
  static GlobalController get to => Get.find();
  var dateFormat = DateFormat("yy-MM-dd hh:mm:ss aaa");
  ThemeMode get themeMode => ThemeMode.system;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final ApiRequest apiRequestInstance = ApiRequest();
  late UserModel userProfile;

  updateUserProfileInstance(var profile) {
    userProfile = UserModel.fromJson(profile);
    update();
  }

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
      backgroundColor: Colors.grey.shade100,
      titleStyle: TextStyle(color: Colors.brown),
      content: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "Are you sure. you want to logout?",
                style: Get.theme.textTheme.subtitle2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      _localStorage.erase();
                      await _googleSignIn.signOut();
                      await _auth.signOut();
                      Get.offAll(LoginPage());
                      Get.back();
                    },
                    child: Text(
                      "yes, Logout",
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "Close",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          ],
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

  updateUserProfile(Map profile) async {
    try {
      final resp = await apiRequestInstance.storeData(RequestBody(
          amendType: 'findOneAndUpdate',
          collectionName: 'users',
          payload: [
            {"_id": userProfile.id},
            {"\$set": profile},
            {"returnNewDocument": true}
          ]));
      print("updated user profile....!");
      print(resp.data);
      // updateUserProfileInstance(resp.data);
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

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.cubeGrid
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 100.0
      ..radius = 10.0
      ..maskType = EasyLoadingMaskType.custom
      ..maskColor = Colors.white60
      ..userInteractions = true
      ..contentPadding = EdgeInsets.all(60)
      ..customAnimation = CustomAnimation();
  }

  @override
  void onInit() {
    if (isUserLoggedIn) {
      final userProfile = getStroageJson(EStorageKeys.PROFILE);
      updateUserProfileInstance(userProfile);
    }
    configLoading();
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
      EasyLoading.show();
      final Map<String, dynamic> payload = {
        "name": {
          "\$regex": '',
          "\$options": 'i',
        },
        "state": {
          "\$regex": userProfile.state,
          "\$options": 'i',
        },
        "city": {
          "\$regex": userProfile.city,
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
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
  }

  clearProductsList() {
    productsList = [];
    update();
  }

  List<ProductModel> productsList = [];
  fetchProductsByShopId(String shopId) async {
    try {
      EasyLoading.show();
      final Map<String, dynamic> payload = {"shopId": shopId};
      final resp = await apiRequestInstance.fetchData(RequestBody(
          amendType: '', collectionName: 'products', payload: payload));
      productsList = productModelFromMap(resp.data);
      update();
      EasyLoading.dismiss();
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
    }
  }
}
