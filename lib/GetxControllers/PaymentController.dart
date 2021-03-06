import 'package:bazaar_bihar/GetxControllers/CartAddressController.dart';
import 'package:bazaar_bihar/GetxControllers/CartController.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/GetxControllers/OrderController.dart';
import 'package:bazaar_bihar/shared/Utils/RequestBody.dart';
import 'package:bazaar_bihar/shared/Utils/orderStatuses.dart';
import 'package:bazaar_bihar/shared/models/PaymentInfoModal.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

// Key Id = rzp_test_XRToCJGiKV3909
// Key Secret = Wks4qubug1YIJHMV7wEh2tqh

class PaymentController extends GetxController {
  static get to => Get.find<PaymentController>();
  final _globalCtrl = GlobalController.to;
  final _cartCtrl = CartController.to;
  final _razorpay = Razorpay();

  _placeOrder(List<Map> orderDetail) async {
    try {
      EasyLoading.show();
      final resp = await _globalCtrl.apiRequestInstance.storeData(
        RequestBody(
          amendType: "insertMany",
          collectionName: "orders",
          payload: [orderDetail],
        ),
      );
      print(resp.data);
      Get.offAllNamed("/");
      Get.snackbar(
        "Successful !",
        "Order placed",
        snackPosition: SnackPosition.BOTTOM,
      );
      _cartCtrl.emptyCart();
      OrderController.to.fetchOrderDetails();
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // TODO:
    // 1. place order using paylater option
    PaymentInfoModal priceInfo = _cartCtrl.getOrderPriceSummary();
    final profile = _globalCtrl.userProfile;
    DateTime now = DateTime.now();
    String updatedDt = _globalCtrl.dateFormat.format(now);

    print("---------priceInfo----------");
    print(priceInfo.toJson());

    final Map priceInfoJson = priceInfo.toJson();
    List shopWiseInfo = priceInfoJson['shopWiseInfo'];
    final Map orderDetail = {
      "paymentId": response.paymentId,
      "status": OrderStatus.INITIATED.name,
      "createdAt": updatedDt,
      "orderBy": profile!.id,
      "userName": profile.fullName,
      "deliveryAddress": CartAddressController.to.selectedAddres?.toJson(),
    };

    final orders = _cartCtrl.carts.map((e) {
      final tempMap = e.toJson();
      final paymentInfo = shopWiseInfo
          .firstWhere((shopInfo) => shopInfo['shopId'] == e.shop.id);
      return {...tempMap, ...orderDetail, ...paymentInfo};
    }).toList();
    _placeOrder(orders);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar("ERROR", response.code.toString() + " - " + response.message!);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar("EXTERNAL_WALLET", response.walletName!);
  }

  initTransaction() {
    PaymentInfoModal priceInfo = _cartCtrl.getOrderPriceSummary();
    final profile = _globalCtrl.userProfile;
    var options = {
      'key': 'rzp_test_XRToCJGiKV3909',
      'amount': priceInfo.totalSp * 100,
      'name': 'BazaarBihar',
      'description': 'Order From BazaarBihar',
      'prefill': {'contact': profile!.mobile, 'email': profile.email}
    };
    print("--------payment options---------");
    print(options);

    _razorpay.open(options);
  }

  @override
  void onInit() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.onInit();
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }
}
