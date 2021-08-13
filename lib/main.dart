import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orca_mob/GetxControllers/GlobalController.dart';
import 'package:orca_mob/pages/Home.dart/HomePage.dart';
import 'package:orca_mob/pages/login-signup/SignupPage.dart';
import 'package:orca_mob/pages/login-signup/loginPage.dart';

void main() async {
  await GetStorage.init();
  final globalController = Get.put(GlobalController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
            name: '/',
            page: () =>
                globalController.isUserLoggedIn ? HomePage() : LoginPage()),
        GetPage(name: '/signup', page: () => SignupPage()),
        // GetPage(name: '/', page: () => HomePage()),
      ],
    ),
  );
}
