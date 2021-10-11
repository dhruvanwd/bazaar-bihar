import 'package:bazaar_bihar/shared/components/StrechedPrimaryButton.dart';
import 'package:bazaar_bihar/shared/login-signup/VerifyMobileCtrl.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyMobile extends StatelessWidget {
  VerifyMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: GetBuilder<VerifyMobileCtrl>(
        init: VerifyMobileCtrl(),
        builder: (_) => Center(
          child: Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Container(
              height: 400,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  if (_.globalCtrl.userProfile!.mobile == "")
                    TextFormField(
                      controller: _.mobileController,
                      autofillHints: [
                        AutofillHints.telephoneNumber,
                        AutofillHints.telephoneNumberLocal,
                        AutofillHints.telephoneNumberDevice,
                      ],
                      keyboardType: TextInputType.phone,
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
                    )
                  else
                    TextFormField(
                      inputFormatters: [
                        TextInputMask(mask: '999 999', reverse: false)
                      ],
                      initialValue: _.globalCtrl.userProfile!.mobile,
                      decoration: InputDecoration(
                          enabled: false,
                          border: UnderlineInputBorder(),
                          labelText: 'Mobile number'),
                    ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          _.sendOtp();
                        },
                        child: Text("Get OTP")),
                  ),
                  TextFormField(
                    controller: _.otpController,
                    inputFormatters: [
                      TextInputMask(mask: '999 999', reverse: false)
                    ],
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(), labelText: 'Enter otp'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter otp';
                      }
                    },
                  ),
                  if (_.otpErrorMsg != null)
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        _.otpErrorMsg!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  Expanded(child: Container()),
                  StrechedPrimaryButton(_.verifyOtp, "Verify OTP"),
                  Padding(padding: EdgeInsets.only(top: 12)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
