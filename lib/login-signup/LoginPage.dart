import 'package:bazaar_bihar/login-signup/SignupController.dart';
import 'package:bazaar_bihar/shared/Utils/extensions.dart';
import 'package:bazaar_bihar/shared/Utils/utils.dart';
import 'package:bazaar_bihar/shared/login-signup/signInSubmitButton.dart';
import 'package:bazaar_bihar/shared/login-signup/LoginGoogleBtn.dart';
import 'package:bazaar_bihar/shared/login-signup/appTitle.dart';
import 'package:bazaar_bihar/shared/login-signup/bezierContainer.dart';
import 'package:bazaar_bihar/shared/login-signup/createAccountLabel.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  String generatedOtp = generateOtp();
  final height = Get.mediaQuery.size.height;
  final _formKey = GlobalKey<FormState>();

  final mobileCtrl = TextEditingController();
  final passwordController = TextEditingController();
  final otpCtrl = TextEditingController();

  bool isWhatsAppLogin = false;

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
        "mobile": mobileCtrl.text.removeWhiteSpaces,
        "password": passwordController.text
      });
    } else {
      print('invalid form');
    }
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: -height * .14,
                right: -Get.mediaQuery.size.width * .4,
                child: BezierContainer(),
              ),
              GetBuilder<SignupController>(
                init: SignupController(),
                builder: (_) => Positioned(
                  child: Form(
                    key: _formKey,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      margin: EdgeInsetsDirectional.only(top: 150),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 50),
                            child: appTitle(),
                          ),
                          TabBar(
                              controller: _tabController,
                              labelColor: Colors.purple,
                              indicatorColor: Colors.purple,
                              padding: EdgeInsets.all(0),
                              isScrollable: true,
                              tabs: [
                                Tab(
                                  text: "Login with OTP",
                                ),
                                Tab(
                                  text: "Login with password",
                                ),
                              ]),
                          TextFormField(
                            controller: mobileCtrl,
                            autofillHints: [
                              AutofillHints.telephoneNumber,
                              AutofillHints.telephoneNumberLocal,
                              AutofillHints.telephoneNumberDevice,
                            ],
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              TextInputMask(
                                  mask: '999 9999 999', reverse: false)
                            ],
                            decoration: InputDecoration(
                                prefixText: "+91",
                                border: UnderlineInputBorder(),
                                labelText: 'Mobile Number'),
                            validator: (value) =>
                                validateMobile(value?.removeAllWhitespace),
                          ),
                          SizedBox(
                            height: 140,
                            child: TabBarView(
                                controller: _tabController,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: SwitchListTile(
                                                  contentPadding:
                                                      EdgeInsets.all(0),
                                                  dense: true,
                                                  secondary: TextButton(
                                                      onPressed: () async {
                                                        await _.sendOtp(
                                                            mobileCtrl.text
                                                                .removeAllWhitespace,
                                                            generatedOtp);
                                                      },
                                                      child: Text("Get OTP")),
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  value: isWhatsAppLogin,
                                                  title: Text(isWhatsAppLogin
                                                      ? "Get OTP on whatsapp"
                                                      : "Get OTP via SMS"),
                                                  onChanged: (value) {
                                                    print(value);
                                                    setState(() {
                                                      isWhatsAppLogin =
                                                          !isWhatsAppLogin;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextFormField(
                                          controller: otpCtrl,
                                          obscureText: _.isObscureText,
                                          inputFormatters: [
                                            TextInputMask(
                                                mask: '999 999', reverse: false)
                                          ],
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              enabled: _.otpSent,
                                              border: UnderlineInputBorder(),
                                              labelText: 'OTP'),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Enter OTP';
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: TextFormField(
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
                                  ),
                                ]),
                          ),
                          Padding(padding: EdgeInsets.only(top: 16)),
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
      ),
    );
  }
}
