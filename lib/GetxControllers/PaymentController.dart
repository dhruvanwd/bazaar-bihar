import 'package:bazaar_bihar/GetxControllers/CartController.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/Utils/RequestBody.dart';
import 'package:bazaar_bihar/models/PaymentInfoModal.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

// Key Id = rzp_test_XRToCJGiKV3909
// Key Secret = Wks4qubug1YIJHMV7wEh2tqh

class PaymentController extends GetxController {
  static get to => Get.find<PaymentController>();
  final _globalCtrl = GlobalController.to;
  final _cartCtrl = CartController.to;
  final _razorpay = Razorpay();

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar("Success", "Order placed");
    Get.offAllNamed("/");
    PaymentInfoModal priceInfo = _cartCtrl.getOrderPriceSummary();
    print("-------------------priceInfo---------------------");
    final Map orderDetail = Map.from({
      "priceInfo": priceInfo.toJson(),
      "paymentId": response.paymentId,
      "status": "INITIATED",
      // ACCEPTED //CANCELLED // IN_TRANSIT
      // DELIVERED
      "cartInfo": _cartCtrl.carts.map((e) => e.toJson()),
    });
    print(orderDetail);
    _globalCtrl.apiRequestInstance.storeData(RequestBody(
        amendType: "insertOne", collectionName: "orders", payload: []));
    _cartCtrl.emptyCart();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar("ERROR", response.code.toString() + " - " + response.message!);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar("EXTERNAL_WALLET", response.walletName!);
  }

  initTransaction() {
    PaymentInfoModal priceInfo = _cartCtrl.getOrderPriceSummary();
    final profile = _globalCtrl.getStroageJson(EStorageKeys.PROFILE);
    var options = {
      'key': 'rzp_test_XRToCJGiKV3909',
      'amount': priceInfo.totalSp,
      'name': 'BazaarBihar',
      'description': 'Order From BazaarBihar',
      'prefill': {'contact': profile['mobile'], 'email': 'test@razorpay.com'}
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
