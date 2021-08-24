import 'package:bazaar_bihar/GetxControllers/UserAddresses.dart';
import 'package:bazaar_bihar/components/StrechedPrimaryButton.dart';
import 'package:bazaar_bihar/models/CartAddressModel.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartAddressForm extends StatelessWidget {
  CartAddressForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  final _localityController = TextEditingController();
  final _zipCodeController = TextEditingController(text: "805110");
  final _stateController = TextEditingController(text: "Bihar");
  final _cityController = TextEditingController(text: "Nawada");
  final _addressLine1Controller = TextEditingController();
  final _mobileController = TextEditingController();
  final _nameController = TextEditingController();

  onCreateAddress() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final Map<String, dynamic> addressDetail = {
        "city": _cityController.text,
        "state": _stateController.text,
        "zipCode": _zipCodeController.text,
        "destinationContact": _mobileController.text,
        "addressLine1": _addressLine1Controller.text,
        "locality": _localityController.text,
        "receiverName": _nameController.text
      };
      print(addressDetail);
      UserAddressesCtrl.to
          .addNewAddress(cartAddressModelFromJson(addressDetail));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black26,
        body: GetBuilder<UserAddressesCtrl>(
          builder: (_addressCtrl) => Center(
            child: SizedBox(
              height: Get.mediaQuery.size.height - 150,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 100, horizontal: 16),
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
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
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
                            decoration: InputDecoration(
                                prefixText: "+91",
                                border: UnderlineInputBorder(),
                                labelText: 'Receiver\'s Contact Number'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter mobile number';
                              }
                            },
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
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: TextFormField(
                            enabled: false,
                            controller: _zipCodeController,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Pin Code'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your pincode.';
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  controller: _stateController,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'State'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter your state.';
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                              ),
                              Flexible(
                                child: TextFormField(
                                  enabled: false,
                                  controller: _cityController,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'City'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter your city.';
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: StrechedPrimaryButton(
                              onCreateAddress, "Add Address"),
                        )
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
