import 'package:bazaar_bihar/GetxControllers/CartAddressController.dart';
import 'package:bazaar_bihar/GetxControllers/CartController.dart';
import 'package:bazaar_bihar/GetxControllers/HomePageController.dart';
import 'package:bazaar_bihar/GetxControllers/OrderController.dart';
import 'package:bazaar_bihar/GetxControllers/PaymentController.dart';
import 'package:bazaar_bihar/GetxControllers/SignupController.dart';
import 'package:bazaar_bihar/components/LoaderPage.dart';
import 'package:bazaar_bihar/pages/CartPage/CheckoutCart.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/pages/Home.dart/HomePage.dart';
import 'package:bazaar_bihar/pages/OrdersPage/ProductsPage.dart';
import 'package:bazaar_bihar/pages/login-signup/SignupPage.dart';
import 'package:bazaar_bihar/pages/login-signup/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/CartPage/CartCarousel.dart';
import 'pages/Home.dart/ShopsPage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  final globalController = Get.put(GlobalController());
  Get.put(HomePageController());
  Get.put(SignupController());
  Get.put(OrderController());
  Get.lazyPut(() => CartController());
  Get.lazyPut(() => CartAddressController());
  Get.lazyPut(() => PaymentController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(primaryColor: Colors.orange),
      darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.grey),
      builder: EasyLoading.init(),
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



// TODO:
// 1. add global refresh api calls if internet is connected
// 2. add gloal loader that can be invoked from anywhere