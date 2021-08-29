import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/GetxControllers/LoginController.dart';
import 'package:bazaar_bihar/Utils/RequestBody.dart';
import 'package:bazaar_bihar/pages/Home.dart/HomePage.dart';
import 'package:bazaar_bihar/pages/login-signup/CustomButton.dart';
import 'package:bazaar_bihar/pages/login-signup/appTitle.dart';
import 'createAccountLabel.dart';
import 'bezierContainer.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) {
    Get.put(LoginController());
  }
  final height = Get.mediaQuery.size.height;
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final apiRequestInstance = GlobalController.to.apiRequestInstance;
  onLogin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final resp = await apiRequestInstance.loginUser(
          RequestBody(
            amendType: 'findOne',
            collectionName: 'users',
            payload: [
              {
                "mobile":
                    usernameController.text.replaceAll(new RegExp(r"\s+"), ""),
                "password": passwordController.text
              }
            ],
          ),
        );
        print("-------resp.data---------");
        print(resp.data);
        GlobalController.to.updateStorage(EStorageKeys.PROFILE, resp.data);
        print(GlobalController.to.getStroageJson(EStorageKeys.PROFILE));
        Get.offAll(HomePage());
      } catch (e) {
        print(e);
        Get.snackbar(
          "Login failed",
          "Invalid credentials.",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.red,
        );
      }
    } else {
      print('invalid form');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: -height * .14,
              right: -Get.mediaQuery.size.width * .4,
              child: BezierContainer(),
            ),
            GetBuilder<LoginController>(
              builder: (_) => Positioned(
                child: Form(
                  key: _formKey,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    margin: EdgeInsetsDirectional.only(top: 150),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 60),
                          child: appTitle(),
                        ),
                        TextFormField(
                          controller: usernameController,
                          autofillHints: [
                            AutofillHints.telephoneNumber,
                            AutofillHints.telephoneNumberLocal,
                            AutofillHints.telephoneNumberDevice,
                          ],
                          inputFormatters: [
                            TextInputMask(mask: '999 9999 999', reverse: false)
                          ],
                          decoration: InputDecoration(
                              prefixText: "+91",
                              border: UnderlineInputBorder(),
                              labelText: 'Mobile Number'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            }
                          },
                        ),
                        Padding(padding: EdgeInsets.only(top: 16)),
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
                              return 'Please enter password';
                            }
                          },
                        ),
                        Padding(padding: EdgeInsets.only(top: 60)),
                        signInSubmitButton(onLogin, "Login"),
                        Padding(padding: EdgeInsets.only(top: 150)),
                        createAccountLabel(
                            'signup', 'Don\'t have an account ?', 'Register')
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
