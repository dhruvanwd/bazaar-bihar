import 'package:flutter/material.dart';
import 'package:orca_mob/GetxControllers/GlobalController.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _globalController = GlobalController.to;
    return Scaffold(
      body: Container(
        child: Center(
          child: TextButton(
            child: Text('Logout'),
            onPressed: _globalController.logout,
          ),
        ),
      ),
    );
  }
}
