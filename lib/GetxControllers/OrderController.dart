import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/Utils/ApiService.dart';
import 'package:bazaar_bihar/Utils/RequestBody.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find();
  final ApiRequest _apiRequestInstance = ApiRequest();
  final _globalCtrl = GlobalController.to;

  var orders = [];

  fetchOrderDetails() async {
    var dateFormat = DateFormat("yy-MM-dd");
    final profile = _globalCtrl.userProfile;
    final resp = await _apiRequestInstance.fetchData(
        RequestBody(amendType: "findOne", collectionName: "orders", payload: {
      "createdAt": {
        "\$regex": "${dateFormat.format(DateTime.now())}",
        "\$options": 'i',
      },
      "orderBy": profile.id
    }));
    print(resp.data);
    if (resp.data != "" && resp.data != null) {
      orders = resp.data;
      update();
    }
  }

  @override
  void onInit() {
    fetchOrderDetails();
    super.onInit();
  }
}
