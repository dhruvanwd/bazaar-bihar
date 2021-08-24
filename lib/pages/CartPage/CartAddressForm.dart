import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartAddressForm extends StatelessWidget {
  CartAddressForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _localityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: SizedBox(
        child: SingleChildScrollView(
          child: Container(
            height: 500,
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
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "Add new address",
                      style: Get.theme.textTheme.headline6!
                          .copyWith(color: Colors.purple),
                    ),
                  ),
                  TextFormField(
                    controller: _localityController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(), labelText: 'Locality'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your house number and locality';
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
