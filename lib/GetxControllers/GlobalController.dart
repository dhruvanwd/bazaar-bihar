import 'dart:convert';
import 'package:bazaar_bihar/login-signup/LoginPage.dart';
import 'package:bazaar_bihar/shared/Utils/ApiService.dart';
import 'package:bazaar_bihar/shared/Utils/RequestBody.dart';
import 'package:bazaar_bihar/shared/Utils/utils.dart';
import 'package:bazaar_bihar/shared/models/CategoryModel.dart';
import 'package:bazaar_bihar/shared/models/ProductsModel.dart';
import 'package:bazaar_bihar/shared/models/ShopModels.dart';
import 'package:bazaar_bihar/shared/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

enum EStorageKeys { PROFILE, SETTINGS, CART, CART_ADDRESS, CATEGORY_VIEWER }

enum ECategoryViewer { CHIP, CARD }

class GlobalController extends GetxController {
  static GlobalController get to => Get.find();
  var dateFormat = DateFormat("yy-MM-dd hh:mm:ss aaa");
  ThemeMode get themeMode => ThemeMode.light;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final ApiRequest apiRequestInstance = ApiRequest();
  UserModel? userProfile;
  ECategoryViewer categoryViewer = ECategoryViewer.CARD;
  updateCategoryViewer(ECategoryViewer catViewer) {
    categoryViewer = catViewer;
    String? catType;
    if (categoryViewer == ECategoryViewer.CARD) {
      catType = "card";
    } else if (categoryViewer == ECategoryViewer.CHIP) {
      catType = "chip";
    }
    updateStorage(EStorageKeys.CATEGORY_VIEWER, {"catType": catType});
    update();
  }

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
    } else if (key == EStorageKeys.CATEGORY_VIEWER) {
      return "CATEGORY_VIEWER";
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
            {"_id": userProfile!.id},
            {"\$set": profile},
            {"returnNewDocument": true}
          ]));
      print("updated user profile....!");
      print(resp.data);
      updateUserProfileInstance(resp.data['value']);
      updateStorage(EStorageKeys.PROFILE, resp.data['value']);
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

  restoreShopByCategory() {
    try {
      final catTypeDetail = getStroageJson(EStorageKeys.CATEGORY_VIEWER);
      if (catTypeDetail == null) return;
      final catType = catTypeDetail['catType'];
      print(catType);
      if (catType != null) {
        if (catType == "card") {
          categoryViewer = ECategoryViewer.CARD;
        } else if (catType == "chip") {
          categoryViewer = ECategoryViewer.CHIP;
        }
      }
      update();
    } catch (e, s) {
      muliPrint([e, s]);
    }
  }

  @override
  void onInit() {
    restoreShopByCategory();
    if (isUserLoggedIn) {
      final userProfile = getStroageJson(EStorageKeys.PROFILE);
      updateUserProfileInstance(userProfile);
      fetchShops(null);
    }

    fetchCategories();
    super.onInit();
  }

  List<ShopModel> shopsList = [];
  List<ShopModel> shopsListByCatId = [];

  clearCurrentShop() {
    shopsListByCatId = [];
    update();
  }

  Map<String, dynamic> categoryWiseShopDetails = {};

  fetchShops(CategoryModel? category) async {
    if (category != null && categoryWiseShopDetails[category.name] != null) {
      shopsListByCatId = categoryWiseShopDetails[category.name];
      print("restored fatched shops ${category.name}");
      update();
      return;
    }
    try {
      final Map<String, dynamic> payload = {
        "name": {
          "\$regex": '',
          "\$options": 'i',
        },
        "state": {
          "\$regex": userProfile!.state,
          "\$options": 'i',
        },
        "city": {
          "\$regex": userProfile!.city,
          "\$options": 'i',
        }
      };

      if (category != null) {
        payload.assign("category", category.toMap());
        EasyLoading.show();
      }
      final resp = await apiRequestInstance.fetchData(RequestBody(
          amendType: '', collectionName: 'shops', payload: payload));

      muliPrint(["fetched shops...!", resp.data]);
      if (category == null) {
        shopsList = shopModelFromJson(resp.data);
      } else {
        shopsListByCatId = shopModelFromJson(resp.data);
        categoryWiseShopDetails[category.name] = shopsListByCatId;
      }
      update();
      if (category != null) EasyLoading.dismiss();
    } catch (e, s) {
      EasyLoading.dismiss();
      muliPrint([e, s]);
    }
  }

  clearProductsList() {
    productsList = [];
    update();
  }

  List<ProductModel> productsList = [];
  Map<String, dynamic> productsCacheByShopId = {};

  fetchProductsByShopId(String shopId) async {
    try {
      if (productsCacheByShopId[shopId] != null) {
        productsList = productsCacheByShopId[shopId];
        print("restored fatched products list $shopId");
        update();
        return;
      }
      EasyLoading.show();
      final Map<String, dynamic> payload = {"shopId": shopId};
      final resp = await apiRequestInstance.fetchData(RequestBody(
          amendType: '', collectionName: 'products', payload: payload));
      productsList = productModelFromMap(resp.data);
      productsCacheByShopId[shopId] = productsList;
      update();
      EasyLoading.dismiss();
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
    }
  }
}
