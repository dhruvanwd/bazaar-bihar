import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './SimpleCloseBtn.dart';

typedef Callback();

confirmationDialog(String contentTxt, Callback callBack) {
  Get.dialog(AlertDialog(
    title: Text("Are you sure?"),
    content: Container(
      child: Text(contentTxt),
    ),
    actionsAlignment: MainAxisAlignment.spaceBetween,
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SimpleCloseBtn(),
          TextButton(
            onPressed: callBack,
            child: Text("Yes"),
          )
        ],
      ),
    ],
  ));
}
