import 'package:bazaar_bihar/Utils/extensions.dart';
import 'package:bazaar_bihar/components/CustomAvatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';

class AppBarMenu extends StatelessWidget {
  final toggleDrawer;
  AppBarMenu(this.toggleDrawer);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalController>(
        builder: (_) => SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAvatar(
                          size: 100,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: _.userProfile!.avatar,
                            errorWidget: (_, url, error) =>
                                Image.asset('images/as.png'),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          _.userProfile!.fullName.capitalizeFirstofEach,
                          style: Get.theme.textTheme.subtitle2!.copyWith(
                            color: Colors.white,
                          ),
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
                    title: Text(
                      "Home",
                      style: Get.theme.textTheme.subtitle2!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    dense: true,
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.monetization_on,
                        size: 20.0, color: Colors.white),
                    title: Text(
                      "Wallet",
                      style: Get.theme.textTheme.subtitle2!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    dense: true,
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed("/cart");
                      toggleDrawer();
                    },
                    leading: Icon(Icons.shopping_cart,
                        size: 20.0, color: Colors.white),
                    title: Text(
                      "Cart",
                      style: Get.theme.textTheme.subtitle2!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    dense: true,
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.star_border,
                        size: 20.0, color: Colors.white),
                    title: Text(
                      "Favorites",
                      style: Get.theme.textTheme.subtitle2!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    dense: true,
                  ),
                  ListTile(
                    onTap: () {},
                    leading:
                        Icon(Icons.settings, size: 20.0, color: Colors.white),
                    title: Text(
                      "Settings",
                      style: Get.theme.textTheme.subtitle2!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    dense: true,
                  ),
                  ListTile(
                    onTap: () {
                      toggleDrawer();
                      _.logout();
                    },
                    leading:
                        Icon(AntDesign.logout, size: 20.0, color: Colors.amber),
                    title: Text(
                      "Logout",
                      style: Get.theme.textTheme.subtitle2!.copyWith(
                        color: Colors.amber,
                      ),
                    ),
                    dense: true,
                  ),
                ],
              ),
            ));
  }
}
