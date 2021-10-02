import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/shared/Utils/ApiService.dart';
import 'package:bazaar_bihar/shared/Utils/RequestBody.dart';
import 'package:bazaar_bihar/shared/Utils/utils.dart';
import 'package:bazaar_bihar/shared/models/OrderModel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find();
  final ApiRequest _apiRequestInstance = ApiRequest();
  final _globalCtrl = GlobalController.to;

  List<OrderModel> orders = [];

  fetchOrderDetails() async {
    // var dateFormat = DateFormat("yy-MM-dd");
    final profile = _globalCtrl.userProfile;
    if (profile == null) return;
    final resp = await _apiRequestInstance.fetchData(
        RequestBody(amendType: "", collectionName: "orders", payload: {
      "createdAt": {
        "\$regex": "",
        "\$options": 'i',
      },
      "orderBy": profile.id
    }));
    muliPrint(["fetched placed orders.........!", resp.data]);
    if (resp.data != "" && resp.data != null) {
      orders = ordersModelFromMap(resp.data);
      update();
    }
  }

  rateNdReviewOrder(OrderModel orderDetail, Map updateDetail) async {
    try {
      EasyLoading.show();
      final resp = await _apiRequestInstance.storeData(RequestBody(
          amendType: 'findOneAndUpdate',
          collectionName: 'orders',
          payload: [
            {"_id": orderDetail.id},
            {"\$set": updateDetail},
            {"returnNewDocument": true}
          ]));
      EasyLoading.dismiss();

      print(resp.data['value']['rating']);
      print(resp.data['value']['review']);
      if (resp.data != "" && resp.data != null) {
        orderDetail.rating = updateDetail['rating'];
        orderDetail.review = updateDetail['review'];
        update();
      }
    } catch (e, s) {
      EasyLoading.dismiss();
      muliPrint([e, s]);
    }
  }

  @override
  void onInit() {
    fetchOrderDetails();
    super.onInit();
  }
}
