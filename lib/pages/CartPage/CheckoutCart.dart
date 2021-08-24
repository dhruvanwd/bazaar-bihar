import 'package:bazaar_bihar/GetxControllers/UserAddresses.dart';
import 'package:bazaar_bihar/pages/CartPage/CartAddressForm.dart';
import 'package:bazaar_bihar/pages/login-signup/appTitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutCart extends StatelessWidget {
  const CheckoutCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserAddressesCtrl>(
      builder: (_addressCtrl) => Scaffold(
        appBar: AppBar(
          title: Text("Confirm order"),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: Get.mediaQuery.size.width,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _addressCtrl.cartAdresses.length == 0
                    ? Container(
                        height: 200,
                        padding: EdgeInsets.only(top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("No address found."),
                            TextButton.icon(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                Get.dialog(
                                  CartAddressForm(),
                                  useSafeArea: true,
                                );
                              },
                              label: Text("Add delivery address"),
                            )
                          ],
                        ),
                      )
                    : Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Select Address",
                                style: Get.theme.textTheme.headline6!
                                    .copyWith(color: Colors.purple),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
