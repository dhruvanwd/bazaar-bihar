import 'package:get/get.dart';
import 'package:orca_mob/Utils/ApiService.dart';

class GlobalController extends GetxController {
  static GlobalController get to => Get.find();
  final ApiRequest apiRequestInstance =
      ApiRequest(baseUrl: 'http:192.168.1.102:8000');
}
