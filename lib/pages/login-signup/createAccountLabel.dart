import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget createAccountLabel(String route, String label, String actionLabel) {
  return InkWell(
    onTap: () {
      Get.toNamed("/$route");
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
                fontSize: 13,
                color: Colors.blueGrey,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            actionLabel,
            style: TextStyle(
                color: Colors.blue, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}
