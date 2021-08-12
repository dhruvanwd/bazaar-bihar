import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orca_mob/pages/login-signup/CustomButton.dart';
import 'package:orca_mob/pages/login-signup/appTitle.dart';
import 'createAccountLabel.dart';
import 'bezierContainer.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final height = Get.mediaQuery.size.height;
  final _formKey = GlobalKey<FormState>();
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
            Positioned(
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
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Email/Mobile Number'),
                      ),
                      Padding(padding: EdgeInsets.only(top: 16)),
                      TextFormField(
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Password'),
                      ),
                      Padding(padding: EdgeInsets.only(top: 60)),
                      signInSubmitButton(() {
                        print("onLogin");
                      }, "Login"),
                      Padding(padding: EdgeInsets.only(top: 150)),
                      createAccountLabel(
                          'signup', 'Don\'t have an account ?', 'Register')
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
