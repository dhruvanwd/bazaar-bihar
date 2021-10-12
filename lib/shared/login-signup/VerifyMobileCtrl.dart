import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/shared/Utils/ApiService.dart';
import 'package:bazaar_bihar/shared/Utils/extensions.dart';
import 'package:bazaar_bihar/shared/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class VerifyMobileCtrl extends GetxController {
  final mobileController = TextEditingController();
  final otpController = TextEditingController();
  final ApiRequest _apiRequestInstance = ApiRequest();
  final globalCtrl = GlobalController.to;
  String generatedOtp = generateOtp();
  String? otpErrorMsg;
  bool otpSent = false;
  bool changeMobile = false;

  editMobile() {
    generatedOtp = generateOtp();
    changeMobile = true;
    otpSent = false;
    update();
  }

  verifyOtp() async {
    otpErrorMsg = null;
    String enteredOTP = otpController.text.removeWhiteSpaces;
    if (enteredOTP.length != 6) {
      otpErrorMsg = "Invalid OTP";
    } else if (generatedOtp == enteredOTP) {
      Map updateProfile = {
        "mobileVerified": true,
      };
      if (mobileController.text.length == 10) {
        updateProfile['mobile'] = mobileController.text;
      }
      await globalCtrl.updateUserProfile(updateProfile);
      Get.snackbar(
        "Mobile number verified",
        "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
      );
      Get.back();
    } else {
      otpErrorMsg = "OTP mismatch";
    }
    update();
  }

  sendOtp() async {
    try {
      EasyLoading.show();
      _apiRequestInstance.sendSMS({
        "to":
            "+91${mobileController.text.length < 10 ? globalCtrl.userProfile!.mobile : mobileController.text}",
        "message":
            """Dear customer, your OTP to login is $generatedOtp. Valid for 10 mins.
          Please ignore this sms if you haven't requested OTP.
      https://bazaarvihar.com
      """,
      }).then((value) {
        otpSent = true;
        print(value.data);
        EasyLoading.dismiss();
        update();
      });
    } catch (e, s) {
      EasyLoading.dismiss();
      muliPrint([e, s]);
    }
  }

  @override
  void onInit() {
    mobileController.text = globalCtrl.userProfile?.mobile ?? "";
    super.onInit();
  }
}
