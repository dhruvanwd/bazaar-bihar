import 'package:flutter/material.dart';

class OfflineDialog extends StatelessWidget {
  const OfflineDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Image.asset(
              "images/no-wifi.png",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
