import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/Utils/ApiService.dart';
import 'package:bazaar_bihar/Utils/RequestBody.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find();
  final ApiRequest apiRequestInstance = ApiRequest();
  final _globalCtrl = GlobalController.to;

  fetchOrderDetails() async {
    var dateFormat = DateFormat("yy-MM-dd");
    final profile = _globalCtrl.getStroageJson(EStorageKeys.PROFILE);
    final resp = await apiRequestInstance.fetchData(
        RequestBody(amendType: "findOne", collectionName: "orders", payload: {
      "createdAt": {
        "\$regex": "${dateFormat.format(DateTime.now())}",
        "\$options": 'i',
      },
      "orderBy": profile['_id']
    }));

    print(resp.data);
  }

  @override
  void onInit() {
    fetchOrderDetails();
    super.onInit();
  }
}
