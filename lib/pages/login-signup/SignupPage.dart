import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orca_mob/pages/login-signup/CustomButton.dart';
import 'package:orca_mob/pages/login-signup/appTitle.dart';
import 'createAccountLabel.dart';
import 'bezierContainer.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);
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
                  margin: EdgeInsetsDirectional.only(top: 140),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: appTitle(),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Full name'),
                      ),
                      Padding(padding: EdgeInsets.only(top: 12)),
                      TextFormField(
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Mobile Number'),
                      ),
                      Padding(padding: EdgeInsets.only(top: 12)),
                      TextFormField(
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Password'),
                      ),
                      Padding(padding: EdgeInsets.only(top: 12)),
                      TextFormField(
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Confirm Password'),
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
                      signInSubmitButton(() {
                        print("onLogin");
                      }, "Create Account"),
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
    );
  }
}
