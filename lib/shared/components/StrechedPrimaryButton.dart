import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StrechedPrimaryButton extends StatelessWidget {
  StrechedPrimaryButton(this.onPressed, this.textTitle,
      {this.disabled = false});
  final onPressed;
  final bool disabled;
  final String textTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  disabled ? Colors.grey.shade300 : Get.theme.primaryColor),
            ),
            onPressed: disabled ? () {} : onPressed,
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
