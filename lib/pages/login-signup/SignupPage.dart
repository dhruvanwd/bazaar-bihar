import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orca_mob/GetxControllers/GlobalController.dart';
import 'package:orca_mob/GetxControllers/SignupController.dart';
import 'package:orca_mob/Utils/RequestBody.dart';
import 'package:orca_mob/pages/Home.dart/HomePage.dart';
import 'package:orca_mob/pages/login-signup/CustomButton.dart';
import 'package:orca_mob/pages/login-signup/appTitle.dart';
import 'createAccountLabel.dart';
import 'bezierContainer.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) {
    Get.put(SignupController());
  }

  final height = Get.mediaQuery.size.height;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final _apiRequestInstance = GlobalController.to.apiRequestInstance;

  onSignup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final resp = await _apiRequestInstance.createUser(RequestBody(
          amendType: 'insertOne',
          collectionName: 'users',
          payload: [
            {
              'fullName': nameController.text,
              'mobile': mobileController.text,
              'role': 'buyer',
              'password': passwordController.text,
              'state': 'bihar',
              'city': 'nawada',
            }
          ]));
      print(resp.data);
      GlobalController.to.updateStorage(EStorageKeys.PROFILE, resp.data);
      print(GlobalController.to.getStroageJson(EStorageKeys.PROFILE));
      Get.offAll(HomePage());
    } else {
      print("Invalid form");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SignupController>(
        builder: (_) => SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: -height * .14,
                right: -Get.mediaQuery.size.width * .4,
                child: BezierContainer(),
              ),
              Positioned(
                child: Form(
                  key: _formKey,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    margin: EdgeInsetsDirectional.only(top: 140),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 30),
                          child: appTitle(),
                        ),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Full name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your name';
                            }
                          },
                        ),
                        Padding(padding: EdgeInsets.only(top: 12)),
                        TextFormField(
                          controller: mobileController,
                          decoration: InputDecoration(
                              prefixText: "+91",
                              border: UnderlineInputBorder(),
                              labelText: 'Mobile Number'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your mobile number';
                            }
                          },
                        ),
                        Padding(padding: EdgeInsets.only(top: 12)),
                        TextFormField(
                          controller: passwordController,
                          obscureText: _.isObscureText,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: _.toogleObscureText,
                                icon: _.isObscureText
                                    ? Icon(
                                        Icons.visibility_off,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                      ),
                              ),
                              labelText: 'Password'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter password';
                            }
                          },
                        ),
                        Padding(padding: EdgeInsets.only(top: 16)),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    enabled: false,
                                    labelText: 'State'),
                                initialValue: "Bihar",
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    enabled: false,
                                    labelText: 'City'),
                                initialValue: "Nawada",
                              ),
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 40)),
                        signInSubmitButton(onSignup, "Create Account"),
                        Padding(padding: EdgeInsets.only(top: 50)),
                        createAccountLabel(
                            'login', 'Already have an account ?', 'login')
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
