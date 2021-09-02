import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/Utils/RequestBody.dart';
import 'package:bazaar_bihar/models/UserModel.dart';
import 'package:bazaar_bihar/pages/Home.dart/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupController extends GetxController {
  bool isObscureText = true;
  static SignupController get to => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  loginUser(var user) async {
    try {
      final resp = await GlobalController.to.apiRequestInstance.loginUser(
        RequestBody(
          amendType: 'findOne',
          collectionName: 'users',
          payload: [user],
        ),
      );
      print("-------resp.data---------");
      print(resp.data);
      GlobalController.to.updateStorage(EStorageKeys.PROFILE, resp.data);
      print(GlobalController.to.getStroageJson(EStorageKeys.PROFILE));
      Get.offAll(HomePage());
    } catch (e) {
      print(e);
      Get.snackbar(
        "Login failed",
        "Invalid credentials.",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.red,
      );
    }
  }

  createUser(var profile) async {
    final _apiRequestInstance = GlobalController.to.apiRequestInstance;
    try {
      EasyLoading.show();
      final resp = await _apiRequestInstance.createUser(RequestBody(
          amendType: 'insertOne', collectionName: 'users', payload: [profile]));
      print(resp.data);
      UserModel.fromJson(resp.data);
      GlobalController.to.updateStorage(EStorageKeys.PROFILE, resp.data);
      print(GlobalController.to.getStroageJson(EStorageKeys.PROFILE));
      Get.offAll(HomePage());
    } catch (e) {
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
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential user = await _auth.signInWithCredential(credential);
      print("-----------user-----------");
      print(user);
      print("-------userProfile--------");
      print(user.additionalUserInfo!.profile);

      final profile = user.additionalUserInfo!.profile!;

      createUser({
        "fullName": profile['name'],
        "email": profile['email'],
        "picture": profile['picture'],
        "avatar": user.user?.photoURL,
        "mobile": user.user?.phoneNumber
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  toogleObscureText() {
    isObscureText = isObscureText ? false : true;
    update();
  }
}
