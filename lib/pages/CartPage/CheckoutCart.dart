import 'package:bazaar_bihar/GetxControllers/PaymentController.dart';
import 'package:bazaar_bihar/GetxControllers/CartAddressController.dart';
import 'package:bazaar_bihar/components/StrechedPrimaryButton.dart';
import 'package:bazaar_bihar/models/CartAddressModel.dart';
import 'package:bazaar_bihar/pages/CartPage/CartAddressForm.dart';
import 'package:bazaar_bihar/pages/CartPage/CartFooter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutCart extends StatelessWidget {
  const CheckoutCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartAddressController>(
      builder: (_addressCtrl) => Scaffold(
        appBar: AppBar(
          title: Text("Confirm order"),
        ),
        persistentFooterButtons: [
          CartFooter(
            StrechedPrimaryButton(() {
              print(_addressCtrl.selectedAddres);
              if (_addressCtrl.selectedAddres.runtimeType != CartAddressModel) {
                Get.snackbar(
                  "Select Address",
                  "select one address",
                  snackPosition: SnackPosition.BOTTOM,
                );
              } else {
                PaymentController.to.initTransaction();
              }
            }, "Place Order..........!"),
          )
        ],
        body: Container(
          width: Get.mediaQuery.size.width,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child:
              // _addressCtrl.cartAdresses.length == 0

              Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "Select Address",
                    style: Get.theme.textTheme.headline6!
                        .copyWith(color: Colors.purple),
                  ),
                ),
                SizedBox(
                  height: 70.0 * _addressCtrl.cartAdresses.length < 200
                      ? 70.0 * _addressCtrl.cartAdresses.length
                      : 200,
                  child: ListView.builder(
                      itemCount: _addressCtrl.cartAdresses.length,
                      itemBuilder: (context, index) {
                        final address = _addressCtrl.cartAdresses[index];
                        return RadioListTile(
                          dense: true,
                          value: address,
                          selected:
                              address.id == _addressCtrl.selectedAddres!.id,
                          groupValue: _addressCtrl.selectedAddres,
                          title: Text("${address.addressLine1}"),
                          subtitle: Text("${address.receiverName}"),
                          secondary: IconButton(
                              onPressed: () {
                                _addressCtrl.deleteUserAddress(address);
                              },
                              icon: Icon(
                                Icons.delete_sharp,
                                color: Colors.red,
                              )),
                          onChanged: (CartAddressModel? address) {
                            if (address != null) {
                              _addressCtrl.updateSelectedAddress(address);
                            }
                          },
                        );
                      }),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _addressCtrl.cartAdresses.length == 0
                          ? Text("No address found.")
                          : Container(),
                      TextButton.icon(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          Get.dialog(
                            CartAddressForm(),
                            useSafeArea: true,
                          );
                        },
                        label: Text("Add new address"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
