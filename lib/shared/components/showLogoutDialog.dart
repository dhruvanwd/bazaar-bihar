import '../../getxControllers/GlobalController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showLogoutDialog() {
  final _glblCtrl = GlobalController.to;
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
                  onPressed: _glblCtrl.logout,
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
