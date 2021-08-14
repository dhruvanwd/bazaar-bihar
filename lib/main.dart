import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orca_mob/GetxControllers/GlobalController.dart';
import 'package:orca_mob/pages/Home.dart/HomePage.dart';
import 'package:orca_mob/pages/OrdersPage/ProductsPage.dart';
import 'package:orca_mob/pages/login-signup/SignupPage.dart';
import 'package:orca_mob/pages/login-signup/loginPage.dart';

import 'pages/Home.dart/ShopsPage.dart';

void main() async {
  await GetStorage.init();
  final globalController = Get.put(GlobalController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(primaryColor: Colors.brown),
      darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.brown),
      // NOTE: Optional - use themeMode to specify the startup theme
      themeMode: globalController.themeMode,
      getPages: [
        GetPage(
            name: '/',
            page: () =>
                globalController.isUserLoggedIn ? HomePage() : LoginPage()),
        GetPage(name: '/signup', page: () => SignupPage()),
        GetPage(name: '/shops', page: () => ShopsPage()),
        GetPage(name: '/products', page: () => ProductsPage()),
        GetPage(
          name: '/',
          page: () => HomePage(),
        ),
      ],
    ),
  );
}
