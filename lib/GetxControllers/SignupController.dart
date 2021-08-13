import 'package:get/get.dart';

class SignupController extends GetxController {
  bool isObscureText = true;

  toogleObscureText() {
    isObscureText = isObscureText ? false : true;
    update();
  }
}
