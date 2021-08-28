import 'package:bazaar_bihar/GetxControllers/CartController.dart';
import 'package:bazaar_bihar/models/PaymentInfoModal.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

// Key Id = rzp_test_XRToCJGiKV3909
// Key Secret = Wks4qubug1YIJHMV7wEh2tqh

class PaymentController extends GetxController {
  static get to => Get.find<PaymentController>();
  final _razorpay = Razorpay();

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar("Success", "Order placed");
    CartController.to.emptyCart();
    Get.offAllNamed("/");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar("ERROR", response.code.toString() + " - " + response.message!);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar("EXTERNAL_WALLET", response.walletName!);
  }

  initTransaction() {
    PaymentInfoModal priceInfo = CartController.to.getOrderPriceSummary();
    var options = {
      'key': 'rzp_test_XRToCJGiKV3909',
      'amount': priceInfo.totalSp,
      'name': 'BazaarBihar',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };

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
