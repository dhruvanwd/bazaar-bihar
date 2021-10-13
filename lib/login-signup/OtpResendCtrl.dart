import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpResendTimerCtrl extends GetxController {
  final FocusNode otpFocusNode = FocusNode();
  final int totalSeconds = 60;
  int secondsDelayed = 0;
  Timer? _timer;
  init() {
    _timer = new Timer.periodic(const Duration(seconds: 1), (timer) {
      secondsDelayed++;
      update();
      if (secondsDelayed >= totalSeconds) {
        secondsDelayed = 0;
        otpFocusNode.requestFocus();
        _timer?.cancel();
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
