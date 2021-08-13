import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orca_mob/Utils/ApiService.dart';

enum EStorageKeys {
  PROFILE,
  SETTINGS,
}

class GlobalController extends GetxController {
  static GlobalController get to => Get.find();
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
}
