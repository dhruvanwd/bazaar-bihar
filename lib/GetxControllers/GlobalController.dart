import 'package:bazaar_bihar/login-signup/LoginPage.dart';
import 'package:bazaar_bihar/pages/generic/OfflineStorage.dart';
import 'package:bazaar_bihar/shared/Utils/ApiService.dart';
import 'package:bazaar_bihar/shared/Utils/CacheApiResponse.dart';
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
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

enum ECategoryViewer { CHIP, CARD }

class GlobalController extends GetxController {
  static GlobalController get to => Get.find();
  var dateFormat = DateFormat("yy-MM-dd hh:mm:ss aaa");
  ThemeMode get themeMode => ThemeMode.light;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final ApiRequest apiRequestInstance = ApiRequest();
  final OfflineStorage offlineStorage = OfflineStorage();
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
    offlineStorage
        .updateStorage(EStorageKeys.CATEGORY_VIEWER, {"catType": catType});
    update();
  }

  updateUserProfileInstance(var profile) {
    userProfile = UserModel.fromJson(profile);
    update();
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
                      offlineStorage.clearStorage();
                      await _googleSignIn.signOut();
                      await _auth.signOut();
                      Get.offAll(() => LoginPage());
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

  updateUserProfile(Map profile) async {
    try {
      EasyLoading.show();
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
      var userProfileJson =
          Map<String, dynamic>.from({...userProfile!.toJson(), ...profile});
      updateUserProfileInstance(userProfileJson);
      EasyLoading.dismiss();
      offlineStorage.updateStorage(EStorageKeys.PROFILE, userProfileJson);
      update();
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
  }

  // ------categories----------

  List<CategoryModel> categories = [];

  fetchCategories() async {
    try {
      final payload =
          RequestBody(amendType: '', collectionName: 'categories', payload: {
        "name": {
          "\$regex": '',
          "\$options": 'i',
        },
      });
      if (storeRestoreData(payload, null) != null) {
        categories = categoryModelFromMap(storeRestoreData(payload, null));
        return;
      }
      final resp = await apiRequestInstance.fetchData(payload);
      storeRestoreData(payload, resp.data);
      categories = categoryModelFromMap(resp.data);
      // closeLoader();
      update();
    } catch (e) {
      print(e);
    }
  }

  restoreShopByCategory() {
    try {
      final catTypeDetail =
          offlineStorage.getStroageJson(EStorageKeys.CATEGORY_VIEWER);
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
    if (offlineStorage.isUserLoggedIn) {
      final userProfile = offlineStorage.getStroageJson(EStorageKeys.PROFILE);
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
