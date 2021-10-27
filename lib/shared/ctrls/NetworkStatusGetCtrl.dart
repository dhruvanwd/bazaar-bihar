import '../components/OfflineDialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkStatusGetCtrl extends GetxController {
  dynamic subscription;

  offlineDialogShow() async {
    await Future.delayed(Duration(seconds: 2));
    Get.defaultDialog(
      content: OfflineDialog(),
      title: "You are offline..!",
      titlePadding: EdgeInsets.all(16),
      confirm: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text("Okay"),
      ),
      titleStyle: TextStyle(color: Colors.brown),
    );
  }

  handleInternetStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      print("internet not connected");
      offlineDialogShow();
    } else {
      print("internet connected");
    }

    update();
  }

  checkInternetStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    handleInternetStatus(connectivityResult);
  }

  @override
  void onInit() {
    checkInternetStatus();
    subscription =
        Connectivity().onConnectivityChanged.listen(handleInternetStatus);
    super.onInit();
  }

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }
}
