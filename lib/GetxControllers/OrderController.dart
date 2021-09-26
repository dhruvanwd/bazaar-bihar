import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/shared/Utils/ApiService.dart';
import 'package:bazaar_bihar/shared/Utils/RequestBody.dart';
import 'package:bazaar_bihar/shared/models/OrderModel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find();
  final ApiRequest _apiRequestInstance = ApiRequest();
  final _globalCtrl = GlobalController.to;

  List<OrderModel> orders = [];

  fetchOrderDetails() async {
    var dateFormat = DateFormat("yy-MM-dd");
    final profile = _globalCtrl.userProfile;
    if (profile == null) return;
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
      orders = ordersModelFromMap(resp.data);
      update();
    }
  }

  @override
  void onInit() {
    fetchOrderDetails();
    super.onInit();
  }
}
