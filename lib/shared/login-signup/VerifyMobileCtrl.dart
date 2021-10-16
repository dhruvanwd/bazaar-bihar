import '../../GetxControllers/GlobalController.dart';
import '../Utils/ApiService.dart';
import '../Utils/extensions.dart';
import '../Utils/utils.dart';
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
    String mobileNumber = mobileController.text.removeAllWhitespace;
    if (enteredOTP.length != 6) {
      otpErrorMsg = "Invalid OTP";
    } else if (generatedOtp == enteredOTP) {
      Map updateProfile = {
        "mobileVerified": true,
      };
      if (mobileNumber.length != 10) {
        Get.snackbar(
          "Invalid mobile number",
          "",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
        );
        return;
      }
      updateProfile['mobile'] = mobileNumber;
      await globalCtrl.updateUserProfile(updateProfile);
      Get.snackbar(
        "Mobile number verified",
        "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
      );
      Get.offAllNamed("/");
    } else {
      otpErrorMsg = "OTP mismatch";
    }
    update();
  }

  sendOtp() async {
    try {
      EasyLoading.show();
      _apiRequestInstance.sendSMS({
        "to": "+91${mobileController.text.removeAllWhitespace}",
        "message": otpTemplate(generatedOtp),
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
    mobileController.text = globalCtrl.userProfile!.mobile!;
    super.onInit();
  }
}
