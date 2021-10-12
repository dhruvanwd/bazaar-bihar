import 'package:bazaar_bihar/pages/Home/HomePage.dart';
import 'package:bazaar_bihar/pages/OfflineStorage.dart';
import 'package:bazaar_bihar/shared/Utils/ApiService.dart';
import 'package:bazaar_bihar/shared/Utils/RequestBody.dart';
import 'package:bazaar_bihar/shared/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupController extends GetxController {
  bool isObscureText = true;
  static SignupController get to => Get.find();
  final ApiRequest _apiRequestInstance = ApiRequest();
  final OfflineStorage _offlineStorage = OfflineStorage();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  loginUser(var user) async {
    EasyLoading.show();
    try {
      var resp;
      if (user['password'] != null) {
        resp = await _apiRequestInstance.loginUser(
          RequestBody(
            amendType: 'findOne',
            collectionName: 'users',
            payload: [user],
          ),
        );
      } else {
        resp = await _apiRequestInstance.storeData(
          RequestBody(
            amendType: 'findOne',
            collectionName: 'users',
            payload: [user],
          ),
        );
      }
      if (!isUserjson(resp.data)) throw Error();
      // _globalCtrl.updateUserProfileInstance(resp.data);
      _offlineStorage.updateStorage(EStorageKeys.PROFILE, resp.data);
      EasyLoading.dismiss();
      Get.offAll(() => HomePage());
    } catch (e) {
      print(e);
      Get.snackbar(
        "Login failed",
        "Invalid credentials.",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.red,
      );
      EasyLoading.dismiss();
      throw e;
    }
  }

  createUser(var profile) async {
    try {
      EasyLoading.show();
      final resp = await _apiRequestInstance.createUser(RequestBody(
          amendType: 'insertOne', collectionName: 'users', payload: [profile]));
      if (!isUserjson(resp.data)) throw Error();
      // _globalCtrl.updateUserProfileInstance(resp.data);
      _offlineStorage.updateStorage(EStorageKeys.PROFILE, resp.data);
      Get.offAll(() => HomePage());
    } catch (e) {
      print(e);
      Get.snackbar(
        "Signup failed",
        "Server error.",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.red,
      );
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();
  }

  Future<String?> signInwithGoogle() async {
    try {
      EasyLoading.show();
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential user = await _auth.signInWithCredential(credential);
      // print("-----------user-----------");
      // print(user);
      // print("-------userProfile--------");
      // print(user.additionalUserInfo!.profile);
      final profile = user.additionalUserInfo!.profile!;
      final rawProfileJson = {
        "fullName": profile['name'],
        "email": profile['email'],
        "picture": profile['picture'],
        "role": "buyer",
        "state": "Bihar",
        "mobileVerified": false,
        "emailVerified": true,
        "city": "Nawada"
      };
      try {
        await loginUser({
          "email": profile['email'],
        });
      } catch (e) {
        if (user.user != null && user.user?.photoURL != null) {
          rawProfileJson["avatar"] = user.user?.photoURL;
        } else if (user.user != null && user.user?.phoneNumber != null) {
          rawProfileJson["mobile"] = user.user?.phoneNumber;
        }
        await createUser(rawProfileJson);
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
      throw e;
    }
  }

  toogleObscureText() {
    isObscureText = isObscureText ? false : true;
    update();
  }
}
