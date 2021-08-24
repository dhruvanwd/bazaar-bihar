import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';

class AppBarMenu extends StatelessWidget {
  final toggleDrawer;
  AppBarMenu(this.toggleDrawer);
  @override
  Widget build(BuildContext context) {
    final profile = GlobalController.to.getStroageJson(EStorageKeys.PROFILE);
    return GetBuilder<GlobalController>(
        builder: (_) => SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 22.0,
                          child: Image.asset('images/as.png'),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          profile['fullName'],
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed("/");
                      toggleDrawer();
                    },
                    leading: Icon(Icons.home, size: 20.0, color: Colors.white),
                    title: Text("Home"),
                    dense: true,
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.monetization_on,
                        size: 20.0, color: Colors.white),
                    title: Text("Wallet"),
                    dense: true,
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed("/cart");
                      toggleDrawer();
                    },
                    leading: Icon(Icons.shopping_cart,
                        size: 20.0, color: Colors.white),
                    title: Text("Cart"),
                    dense: true,
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.star_border,
                        size: 20.0, color: Colors.white),
                    title: Text("Favorites"),
                    dense: true,
                  ),
                  ListTile(
                    onTap: () {},
                    leading:
                        Icon(Icons.settings, size: 20.0, color: Colors.white),
                    title: Text("Settings"),
                    dense: true,
                  ),
                ],
              ),
            ));
  }
}
