import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orca_mob/GetxControllers/GlobalController.dart';
import 'package:orca_mob/pages/Home.dart/ShopByCategory.dart';
import 'package:orca_mob/pages/Home.dart/ShopsList.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

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
