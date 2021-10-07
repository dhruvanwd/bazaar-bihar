import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

typedef void LoginBtn();

class LoginGoogleBtn extends StatelessWidget {
  LoginGoogleBtn(this.onPressed);

  final LoginBtn onPressed;
  final colorizeColors = [
    Colors.orange,
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  final colorizeTextStyle = TextStyle(
    fontSize: 20.0,
    fontFamily: 'Horizon',
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedTextKit(
            repeatForever: true,
            onTap: onPressed,
            animatedTexts: [
              ColorizeAnimatedText(
                "Login with Google",
                textStyle: colorizeTextStyle,
                colors: colorizeColors,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
