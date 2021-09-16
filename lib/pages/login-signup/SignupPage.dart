import 'package:bazaar_bihar/CityStateDropDown/StateCityModel.dart';
import 'package:bazaar_bihar/pages/login-signup/LoginGoogleBtn.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/SignupController.dart';
import 'package:bazaar_bihar/pages/login-signup/CustomButton.dart';
import 'package:bazaar_bihar/pages/login-signup/appTitle.dart';
import 'CityDropdownSelector.dart';
import 'StateCityForm.dart';
import 'StateDropdownSelector.dart';
import 'createAccountLabel.dart';
import 'bezierContainer.dart';

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

  onSignup() async {
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
      SignupController.to.createUser({
        'fullName': nameController.text,
        'mobile': mobileController.text,
        'role': 'buyer',
        'state': selectedState?.state,
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
                        StateCityForm(
                          cities: selectedState?.districts,
                          handleCityChange: handleCityChange,
                          handleStateChange: handleStateChange,
                          selectedState: selectedState,
                        ),
                        Padding(padding: EdgeInsets.only(top: 60)),
                        signInSubmitButton(onSignup, "Create Account"),
                        Padding(padding: EdgeInsets.only(top: 50)),
                        LoginGoogleBtn(),
                        Padding(padding: EdgeInsets.only(top: 30)),
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
