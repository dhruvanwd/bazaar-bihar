import 'dart:math';
import 'package:bazaar_bihar/GetxControllers/CartAddressController.dart';
import 'package:bazaar_bihar/shared/Utils/utils.dart';
import 'package:bazaar_bihar/shared/components/SimpleCloseBtn.dart';
import 'package:bazaar_bihar/shared/components/StrechedPrimaryButton.dart';
import 'package:bazaar_bihar/shared/login-signup/StateCityForm.dart';
import 'package:bazaar_bihar/shared/models/CartAddressModel.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartAddressForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _localityController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _addressLine1Controller = TextEditingController();
  final _mobileController = TextEditingController();
  final _nameController = TextEditingController();

  final rand = Random();

  onCreateAddress() {
    if (_formKey.currentState!.validate()) {
      final _addressCtrl = CartAddressController.to;
      if (_addressCtrl.selectedState == null ||
          _addressCtrl.selectedCity == null) {
        Get.snackbar("Invalid city state", "Select your city and state");
        return;
      }
      _formKey.currentState!.save();
      final Map<String, dynamic> addressDetail = {
        "city": _addressCtrl.selectedCity?.city,
        "state": _addressCtrl.selectedState?.state,
        "zipCode": _zipCodeController.text,
        "destinationContact": _mobileController.text.removeAllWhitespace,
        "addressLine1": _addressLine1Controller.text,
        "locality": _localityController.text,
        "receiverName": _nameController.text,
        "_id": "tempId${rand.nextDouble()}"
      };
      print(addressDetail);
      _addressCtrl.addNewAddress(cartAddressModelFromJson(addressDetail));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black26,
        body: GetBuilder<CartAddressController>(
          builder: (_addressCtrl) => Center(
            child: SizedBox(
              height: Get.mediaQuery.size.height - 120,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "Add new address",
                            style: Get.theme.textTheme.headline6!
                                .copyWith(color: Colors.purple),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Receiver\'s Name'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter receiver\'s name';
                              } else if (value.length < 3) {
                                return "Name too small";
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: TextFormField(
                            controller: _mobileController,
                            inputFormatters: [
                              TextInputMask(
                                  mask: '999 9999 999', reverse: false)
                            ],
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                prefixText: "+91",
                                border: UnderlineInputBorder(),
                                labelText: 'Receiver\'s Contact Number'),
                            validator: (value) =>
                                validateMobile(value?.removeAllWhitespace),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: TextFormField(
                            controller: _addressLine1Controller,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Address Line 1'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your house address';
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: TextFormField(
                            controller: _localityController,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Locality (Landmark)'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your house number and locality';
                              }
                            },
                          ),
                        ),
                        StateCityForm(
                          cities: _addressCtrl.selectedState?.districts,
                          handleCityChange: _addressCtrl.handleCityChange,
                          handleStateChange: _addressCtrl.handleStateChange,
                          selectedState: _addressCtrl.selectedState,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: TextFormField(
                            controller: _zipCodeController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Pin Code'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your pincode.';
                              } else if (value.length != 6) {
                                return "Invalid pin code";
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: StrechedPrimaryButton(
                              onCreateAddress, "Add Address"),
                        ),
                        SimpleCloseBtn()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
