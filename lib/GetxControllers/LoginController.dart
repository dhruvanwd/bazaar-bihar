import 'package:get/get.dart';

class LoginController extends GetxController {
  bool isObscureText = true;

  toogleObscureText() {
    isObscureText = isObscureText ? false : true;
    update();
  }
}
