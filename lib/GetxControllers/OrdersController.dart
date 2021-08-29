import 'package:bazaar_bihar/Utils/ApiService.dart';
import 'package:get/get.dart';

class MyController extends GetxController {
  static MyController get to => Get.find();
  final ApiRequest apiRequestInstance = ApiRequest();

  fetchOrderDetails() {}

  @override
  void onInit() {
    super.onInit();
  }
}
