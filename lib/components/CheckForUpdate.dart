import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';

class UpdateMyApp extends StatefulWidget {
  @override
  _UpdateMyAppState createState() => _UpdateMyAppState();
}

class _UpdateMyAppState extends State<UpdateMyApp> {
  AppUpdateInfo? _updateInfo;
  bool _flexibleUpdateAvailable = false;
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) {
      showSnack(e.toString());
    });
  }

  void showSnack(String text) {
    Get.snackbar("app update", text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Center(
            child: Text('Update info: $_updateInfo'),
          ),
          ElevatedButton(
            child: Text('Check for Update'),
            onPressed: () => checkForUpdate(),
          ),
          ElevatedButton(
            child: Text('Perform immediate update'),
            onPressed: _updateInfo?.updateAvailability ==
                    UpdateAvailability.updateAvailable
                ? () {
                    InAppUpdate.performImmediateUpdate()
                        .catchError((e) => showSnack(e.toString()));
                  }
                : null,
          ),
          ElevatedButton(
            child: Text('Start flexible update'),
            onPressed: _updateInfo?.updateAvailability ==
                    UpdateAvailability.updateAvailable
                ? () {
                    InAppUpdate.startFlexibleUpdate().then((_) {
                      setState(() {
                        _flexibleUpdateAvailable = true;
                      });
                    }).catchError((e) {
                      showSnack(e.toString());
                    });
                  }
                : null,
          ),
          ElevatedButton(
            child: Text('Complete flexible update'),
            onPressed: !_flexibleUpdateAvailable
                ? null
                : () {
                    InAppUpdate.completeFlexibleUpdate().then((_) {
                      showSnack("Success!");
                    }).catchError((e) {
                      showSnack(e.toString());
                    });
                  },
          )
        ],
      ),
    );
  }
}
