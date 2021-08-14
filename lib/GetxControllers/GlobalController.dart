import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orca_mob/GetxControllers/HomePageController.dart';
import 'package:orca_mob/Utils/ApiService.dart';
import 'package:orca_mob/Utils/RequestBody.dart';
import 'package:orca_mob/pages/login-signup/LoginPage.dart';

enum EStorageKeys {
  PROFILE,
  SETTINGS,
}

class GlobalController extends GetxController {
  static GlobalController get to => Get.find();
  ThemeMode get themeMode => ThemeMode.system;
  HomePageController get homePageCtrl => HomePageController.to;
  final ApiRequest apiRequestInstance =
      ApiRequest(baseUrl: 'http://192.168.1.100:8000');

  final localStorage = GetStorage();

  getKeyFromEnum(EStorageKeys key) {
    if (key == EStorageKeys.PROFILE) {
      return "profile";
    } else if (key == EStorageKeys.SETTINGS) {
      return 'settings';
    }
  }

  updateTheme() {}

  logout() {
    localStorage.erase();
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
      localStorage.write(keyName, jsonEncoder.convert(data));
    } catch (e) {
      print("updateStorage Error.....!");
      print(e);
    }
  }

  getStroageJson(EStorageKeys key) {
    try {
      String keyName = getKeyFromEnum(key);
      String rawJson = localStorage.read(keyName);
      Map<String, dynamic> jsonData =
          Map<String, dynamic>.from(jsonDecode(rawJson));
      return jsonData;
    } catch (e) {
      print("getStroageJson Error.....!");
      print(e);
    }
  }

  // ------categories----------

  var categories = [];

  fetchCategories() async {
    final resp = await apiRequestInstance.fetchData(
        RequestBody(amendType: '', collectionName: 'categories', payload: {
      "name": {
        "\$regex": '',
        "\$options": 'i',
      },
    }));
    categories = resp.data;
    update();
    print(resp.data);
  }

  createImageUrl(dynamic image) =>
      'https://bazaar-bihar.s3.ap-south-1.amazonaws.com/' + image['filename'];

  @override
  void onInit() {
    Get.put(HomePageController());
    super.onInit();
  }
}
