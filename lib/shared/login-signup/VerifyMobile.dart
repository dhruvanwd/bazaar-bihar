import 'package:bazaar_bihar/shared/Utils/utils.dart';
import '../components/SimpleCloseBtn.dart';
import '../components/StrechedPrimaryButton.dart';
import './VerifyMobileCtrl.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
                  if (_.globalCtrl.userProfile!.mobile == "" ||
                      _.globalCtrl.userProfile!.mobile == null ||
                      _.changeMobile)
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
                        labelText: 'Mobile Number',
                      ),
                      validator: (value) =>
                          validateMobile(value?.removeAllWhitespace),
                    )
                  else
                    InkWell(
                      onTap: () {
                        print("Edit moble");
                        _.editMobile();
                      },
                      child: TextFormField(
                        inputFormatters: [
                          TextInputMask(mask: '999 999', reverse: false)
                        ],
                        initialValue: _.globalCtrl.userProfile!.mobile,
                        decoration: InputDecoration(
                            enabled: false,
                            suffixIcon: Icon(Icons.edit_outlined),
                            border: UnderlineInputBorder(),
                            labelText: 'Mobile number'),
                      ),
                    ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(top: 8),
                    child: InkWell(
                      onTap: () {
                        _.sendOtp();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Get OTP",
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_.otpSent)
                    TextFormField(
                      controller: _.otpController,
                      inputFormatters: [
                        TextInputMask(mask: '999 999', reverse: false)
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter otp'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter otp';
                        }
                      },
                      onChanged: (value) {
                        _.update();
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
                  StrechedPrimaryButton(
                    _.verifyOtp,
                    "Verify OTP",
                    disabled: _.otpController.text.length != 7,
                  ),
                  SimpleCloseBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
