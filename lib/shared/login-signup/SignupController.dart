import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Utils/ApiService.dart';
import '../Utils/RequestBody.dart';
import '../Utils/utils.dart';
import '../generic/OfflineStorage.dart';
import '../../Home/HomePage.dart';

class SignupController extends GetxController {
  static SignupController get to => Get.find();
  bool isObscureText = true;
  final ApiRequest _apiRequestInstance = ApiRequest();
  final OfflineStorage _offlineStorage = OfflineStorage();
  bool otpSent = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String? otpErrorTxt;

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
      _offlineStorage.updateStorage(EStorageKeys.PROFILE, resp.data);
      EasyLoading.dismiss();
      Get.offAll(() => HomePage());
    } catch (e) {
      if (user['password'] == null) {
        Get.snackbar(
          "User not Registered",
          "Create account",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.red,
        );
      } else {
        Get.snackbar(
          "Login failed",
          "Invalid credentials.",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.red,
        );
      }
      print(e);

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

  sendOtp(String mobileNumber, var otp) async {
    try {
      EasyLoading.show();
      var resp = await _apiRequestInstance.sendSMS({
        "to": "+91$mobileNumber",
        "message": otpTemplate(otp),
      });
      otpSent = true;
      print(resp.data);
      EasyLoading.dismiss();
      update();
    } catch (e, s) {
      EasyLoading.dismiss();
      muliPrint([e, s]);
    }
  }

  toogleObscureText() {
    isObscureText = isObscureText ? false : true;
    update();
  }

  loginWithPassword(GlobalKey<FormState> _formKey,
      {required String password, required String mobile}) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (password.isEmpty) {
        Get.snackbar(
          "Enter your password",
          "password is required",
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      loginUser({"mobile": mobile, "password": password});
    } else {
      print('invalid form');
    }
  }

  clearOtpMismatchError() {
    if (otpErrorTxt != null) {
      otpErrorTxt = null;
      update();
    }
  }

  otpMisMatchError() async {
    EasyLoading.show();
    await Future.delayed(Duration(seconds: 1));
    otpErrorTxt = "OTP mismatch";
    EasyLoading.dismiss();
    update();
  }

  @override
  void onClose() {
    print("Closing SignupController .....!");
    super.onClose();
  }
}
