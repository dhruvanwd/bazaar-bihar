import 'package:flutter/material.dart';

class ShopUnavailable extends StatelessWidget {
  const ShopUnavailable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("No shop found...."),
      ),
    );
  }
}
