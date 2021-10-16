import 'package:bazaar_bihar/pages/Wallet/WalletHome.dart';
import 'package:bazaar_bihar/shared/Utils/utils.dart';
import 'package:bazaar_bihar/pages/CartPage/CheckoutCart.dart';
import 'package:bazaar_bihar/pages/Home/HomePage.dart';
import 'package:bazaar_bihar/pages/OrdersPage/ProductsPage.dart';
import 'package:bazaar_bihar/shared/generic/OfflineStorage.dart';
import 'package:bazaar_bihar/shared/login-signup/LoginPage.dart';
import 'package:bazaar_bihar/shared/login-signup/SignupPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/CartPage/CartCarousel.dart';
import 'pages/Home/ShopsPage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final OfflineStorage offlineStorage = OfflineStorage();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.orange,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.grey),
      builder: EasyLoading.init(),
      themeMode: ThemeMode.light,
      initialRoute: "/",
      getPages: [
        GetPage(
            name: '/',
            page: () =>
                offlineStorage.isUserLoggedIn ? HomePage() : LoginPage()),
        GetPage(name: '/signup', page: () => SignupPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/shops', page: () => ShopsPage()),
        GetPage(name: '/products', page: () => ProductsPage()),
        GetPage(name: '/cart', page: () => CartCarousel()),
        GetPage(name: '/checkout', page: () => CheckoutCart()),
        GetPage(name: '/wallet', page: () => WalletHome()),
      ],
    ),
  );
  configLoading();
}



// TODO:
// 1. add global refresh api calls if internet is connected
// 2. add gloal loader that can be invoked from anywhere