import '../components/customAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:math';

import '../models/ImagesModel.dart';

isUserjson(var profile) {
  print("---------isUserjson----------");
  print(profile);
  return profile['fullName'] != null && profile['role'] != null;
}

final rupeeSymbol = "₹";
muliPrint(List<dynamic> arguments) {
  arguments.forEach((element) => print(element));
}

calculateDiscount(mrp, sp) {
  final a = mrp is String ? double.parse(mrp) : mrp;
  final b = sp is String ? double.parse(sp) : sp;
  assert(a >= b);
  return ((((a - b) / (a))) * 100).toStringAsFixed(2);
}

createImageUrl(ImageModel image) {
  if (image.filename.contains("https://"))
    return image.filename;
  else
    return 'https://bazaar-bihar.s3.ap-south-1.amazonaws.com/' + image.filename;
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 100.0
    ..radius = 10.0
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = Colors.white60
    ..userInteractions = true
    ..contentPadding = EdgeInsets.all(60)
    ..customAnimation = CustomAnimation();
}

final lightGradient = LinearGradient(
  colors: [
    Colors.lightBlue.shade50,
    Colors.blueGrey.shade50,
  ],
);
String generateOtp() {
  int min = 100000;
  int max = 999999;
  int randomminmax = min + Random().nextInt(max - min);
  muliPrint(["Otp generated", randomminmax]);

  return randomminmax.toString();
}
