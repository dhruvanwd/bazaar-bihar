import 'dart:convert';

import 'package:get_storage/get_storage.dart';

enum EStorageKeys { PROFILE, SETTINGS, CART, CART_ADDRESS, CATEGORY_VIEWER }

class OfflineStorage {
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

  updateStorage(EStorageKeys key, dynamic data) {
    try {
      String keyName = getKeyFromEnum(key);
      final jsonEncoder = JsonEncoder();
      _localStorage.write(keyName, jsonEncoder.convert(data));
    } catch (e) {
      print(e);
    }
  }

  clearStorage() {
    _localStorage.erase();
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

  get isUserLoggedIn {
    try {
      return getStroageJson(EStorageKeys.PROFILE) != null;
    } catch (e) {
      return false;
    }
  }
}
