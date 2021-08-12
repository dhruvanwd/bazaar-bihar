import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget signInSubmitButton(dynamic onTap, String label) {
  final primaryGradient = [Colors.blue, Colors.purple];
  return InkWell(
    onTap: onTap,
    child: Container(
      width: Get.mediaQuery.size.width,
      padding: EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2)
        ],
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: primaryGradient,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
        ),
      ),
    ),
  );
}
