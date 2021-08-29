import 'package:bazaar_bihar/GetxControllers/CartController.dart';
import 'package:bazaar_bihar/GetxControllers/HomePageController.dart';
import 'package:bazaar_bihar/GetxControllers/OrderController.dart';
import 'package:bazaar_bihar/GetxControllers/PaymentController.dart';
import 'package:bazaar_bihar/components/LoaderPage.dart';
import 'package:bazaar_bihar/pages/CartPage/CheckoutCart.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/pages/Home.dart/HomePage.dart';
import 'package:bazaar_bihar/pages/OrdersPage/ProductsPage.dart';
import 'package:bazaar_bihar/pages/login-signup/SignupPage.dart';
import 'package:bazaar_bihar/pages/login-signup/loginPage.dart';
import 'pages/CartPage/CartCarousel.dart';
import 'pages/Home.dart/ShopsPage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  final globalController = Get.put(GlobalController());
  Get.put(HomePageController());
  Get.put(CartController());
  Get.put(OrderController());
  Get.put(PaymentController());
  Get.lazyPut(() => OrderController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(primaryColor: Colors.blueGrey),
      darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.grey),
      themeMode: globalController.themeMode,
      getPages: [
        GetPage(
            name: '/',
            page: () =>
                globalController.isUserLoggedIn ? HomePage() : LoginPage()),
        GetPage(name: "/loader", page: () => LoaderPage()),
        GetPage(name: '/signup', page: () => SignupPage()),
        GetPage(name: '/shops', page: () => ShopsPage()),
        GetPage(name: '/products', page: () => ProductsPage()),
        GetPage(name: '/cart', page: () => CartCarousel()),
        GetPage(name: '/checkout', page: () => CheckoutCart()),
      ],
    ),
  );
}
