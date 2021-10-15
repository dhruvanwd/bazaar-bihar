import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'OtpResendCtrl.dart';
import '../Utils/utils.dart';
import '../login-signup/signInSubmitButton.dart';
import '../login-signup/LoginGoogleBtn.dart';
import '../login-signup/appTitle.dart';
import '../login-signup/bezierContainer.dart';
import '../login-signup/createAccountLabel.dart';
import 'SignupController.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final height = Get.mediaQuery.size.height;
  final _formKey = GlobalKey<FormState>();
  final _mobileCtrl = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpCtrl = TextEditingController();
  bool isWhatsAppLogin = false;
  final otpResendCtrl = Get.put(OtpResendTimerCtrl());

  onLogin(SignupController _) async {
    try {
      if (_tabController.index == 0) {
        if (otpResendCtrl.generatedOtp == _otpCtrl.text.removeAllWhitespace) {
          try {
            _.loginUser({
              "mobile": _mobileCtrl.text.removeAllWhitespace,
            });
          } catch (e, s) {
            muliPrint([e, s]);
          }
        } else {
          _.otpMisMatchError();
        }
      } else
        _.loginWithPassword(_formKey,
            mobile: _mobileCtrl.text.removeAllWhitespace,
            password: _passwordController.text.removeAllWhitespace);
    } catch (e) {
      print(e);
    }
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      print(_tabController.index);
    });
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 32.0),
                            child: TabBar(
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
                          ),
                          GetBuilder<OtpResendTimerCtrl>(
                              builder: (_otpCtrl) => TextFormField(
                                    controller: _mobileCtrl,
                                    autofillHints: otpResendCtrl
                                                .secondsDelayed ==
                                            0
                                        ? [
                                            AutofillHints.telephoneNumber,
                                            AutofillHints.telephoneNumberLocal,
                                            AutofillHints.telephoneNumberDevice,
                                          ]
                                        : null,
                                    autofocus: true,
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      TextInputMask(
                                          mask: '999 9999 999', reverse: false)
                                    ],
                                    decoration: InputDecoration(
                                        prefixText: "+91",
                                        enabled:
                                            otpResendCtrl.secondsDelayed == 0,
                                        border: OutlineInputBorder(),
                                        labelText: 'Mobile Number'),
                                    validator: (value) {
                                      _.clearOtpMismatchError();
                                      otpResendCtrl.resetTimer();
                                      validateMobile(
                                          value?.removeAllWhitespace);
                                    },
                                  )),
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
                                                  activeColor: Colors.green,
                                                  inactiveThumbColor:
                                                      Colors.blue,
                                                  secondary: TextButton(
                                                    onPressed: () async {
                                                      if (otpResendCtrl
                                                              .secondsDelayed !=
                                                          0) {
                                                        print(
                                                            "otp minimum thresold added");
                                                        return;
                                                      }
                                                      await _.sendOtp(
                                                          _mobileCtrl.text
                                                              .removeAllWhitespace,
                                                          otpResendCtrl
                                                              .generatedOtp);
                                                      otpResendCtrl.init();
                                                    },
                                                    child: GetBuilder<
                                                        OtpResendTimerCtrl>(
                                                      builder: (_timerCtrl) {
                                                        if (_timerCtrl
                                                                .secondsDelayed !=
                                                            0)
                                                          return Text(
                                                            "Resend in ${_timerCtrl.totalSeconds - _timerCtrl.secondsDelayed}s",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .blueGrey,
                                                            ),
                                                          );
                                                        return Text("Get OTP");
                                                      },
                                                    ),
                                                  ),
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
                                          controller: _otpCtrl,
                                          focusNode: otpResendCtrl.otpFocusNode,
                                          inputFormatters: [
                                            TextInputMask(
                                                mask: '999 999', reverse: false)
                                          ],
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              enabled: _.otpSent,
                                              errorText: _.otpErrorTxt,
                                              border: OutlineInputBorder(),
                                              labelText: 'OTP'),
                                          validator: (value) {
                                            _.clearOtpMismatchError();
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
                                    margin: EdgeInsets.only(top: 40),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: _.isObscureText,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
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
                          signInSubmitButton(() {
                            onLogin(_);
                          }, "Login"),
                          Padding(padding: EdgeInsets.only(top: 60)),
                          LoginGoogleBtn(),
                          Padding(padding: EdgeInsets.only(top: 30)),
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
