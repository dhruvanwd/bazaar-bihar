import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StrechedPrimaryButton extends StatelessWidget {
  StrechedPrimaryButton(this.onPressed, this.textTitle);
  final onPressed;
  final String textTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Get.theme.primaryColor),
            ),
            onPressed: onPressed,
            child: Text(
              "$textTitle",
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
