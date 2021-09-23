import 'package:bazaar_bihar/login-signup/SignupController.dart';
import 'package:bazaar_bihar/shared/Utils/extensions.dart';
import 'package:bazaar_bihar/shared/login-signup/signInSubmitButton.dart';
import 'package:bazaar_bihar/shared/login-signup/LoginGoogleBtn.dart';
import 'package:bazaar_bihar/shared/login-signup/appTitle.dart';
import 'package:bazaar_bihar/shared/login-signup/bezierContainer.dart';
import 'package:bazaar_bihar/shared/login-signup/createAccountLabel.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final height = Get.mediaQuery.size.height;
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  onLogin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (passwordController.text.isEmpty) {
        Get.snackbar(
          "Enter your password",
          "password is required",
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      SignupController.to.loginUser({
        "mobile": usernameController.text.removeWhiteSpaces,
        "password": passwordController.text
      });
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
            GetBuilder<SignupController>(
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
                        Padding(padding: EdgeInsets.only(top: 60)),
                        LoginGoogleBtn(_.signInwithGoogle),
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
