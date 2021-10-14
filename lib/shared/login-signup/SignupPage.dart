import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './SignupController.dart';
import '../CityStateDropDown/StateCityModel.dart';
import '../Utils/utils.dart';
import '../login-signup/CityDropdownSelector.dart';
import '../login-signup/signInSubmitButton.dart';
import '../login-signup/LoginGoogleBtn.dart';
import '../login-signup/StateCityForm.dart';
import '../login-signup/appTitle.dart';
import '../login-signup/bezierContainer.dart';
import '../login-signup/createAccountLabel.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final height = Get.mediaQuery.size.height;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final cityController = TextEditingController();
  StateCity? selectedState;
  CityModel? selectedCity;

  onSignup(SignupController _) async {
    if (_formKey.currentState!.validate()) {
      if (selectedState == null) {
        Get.snackbar("Select your state", "state is required",
            snackPosition: SnackPosition.BOTTOM);
        return;
      } else if (selectedCity == null) {
        Get.snackbar("Select your city", "city is required",
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
      _formKey.currentState!.save();
      _.createUser({
        'fullName': nameController.text,
        'mobile': mobileController.text.removeAllWhitespace,
        'role': 'buyer',
        'state': selectedState?.state,
        "mobileVerified": false,
        "emailVerified": false,
        "city": selectedCity?.city,
        'password': passwordController.text,
      });
    } else {
      print("Invalid form");
    }
  }

  // stateCityList

  handleStateChange(StateCity state) {
    setState(() {
      selectedState = state;
      selectedCity = null;
      print(state.state);
    });
  }

  handleCityChange(CityModel city) {
    setState(() {
      selectedCity = city;
      print(city.city);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SignupController>(
        init: SignupController(),
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
                          autofillHints: [
                            AutofillHints.telephoneNumber,
                            AutofillHints.telephoneNumberLocal,
                            AutofillHints.telephoneNumberDevice,
                          ],
                          inputFormatters: [
                            TextInputMask(mask: '999 9999 999', reverse: false)
                          ],
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              prefixText: "+91",
                              border: UnderlineInputBorder(),
                              labelText: 'Mobile Number'),
                          validator: (value) =>
                              validateMobile(value?.removeAllWhitespace),
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
                        StateCityForm(
                          cities: selectedState?.districts,
                          handleCityChange: handleCityChange,
                          handleStateChange: handleStateChange,
                          selectedState: selectedState,
                        ),
                        Padding(padding: EdgeInsets.only(top: 40)),
                        signInSubmitButton(() {
                          onSignup(_);
                        }, "Create Account"),
                        Padding(padding: EdgeInsets.only(top: 60)),
                        LoginGoogleBtn(_.signInwithGoogle),
                        Padding(padding: EdgeInsets.only(top: 30)),
                        createAccountLabel(
                            'login', 'Already have an account ?', 'Login')
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
