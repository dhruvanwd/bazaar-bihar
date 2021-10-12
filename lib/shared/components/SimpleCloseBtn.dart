import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimpleCloseBtn extends StatelessWidget {
  const SimpleCloseBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text("Close"),
      ),
    );
  }
}
