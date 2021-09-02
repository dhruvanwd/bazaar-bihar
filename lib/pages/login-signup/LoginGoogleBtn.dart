import 'package:bazaar_bihar/GetxControllers/SignupController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginGoogleBtn extends StatelessWidget {
  const LoginGoogleBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        SignupController.to.signInwithGoogle();
      },
      child: SizedBox(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "images/google.jpg",
              height: 28,
              width: 28,
            ),
            Text(
              "Login with Google",
              style: Get.theme.textTheme.subtitle2!.copyWith(
                color: Colors.grey.shade800,
              ),
            )
          ],
        ),
      ),
    );
  }
}
