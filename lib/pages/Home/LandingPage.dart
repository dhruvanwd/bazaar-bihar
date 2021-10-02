import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/pages/Home/ShopByCategory.dart';
import 'package:bazaar_bihar/pages/Home/ShopsList.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);
// TODO: users should be able to rate shops and orders
// TODO: setup otp;
// also give option to verify  E-mail if user logged in with mobile
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.mediaQuery.size.height - 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ShopByCategory(),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Suggested Shops",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: GetBuilder<GlobalController>(
                builder: (_) => ShopsList(_.shopsList)),
          )
        ],
      ),
    );
  }
}
