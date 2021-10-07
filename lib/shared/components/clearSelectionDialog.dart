import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

clearSelectionDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    title: Text("Are you sure..."),
    content: Text("...you want to clear the selection"),
    actions: [
      TextButton(
        child: Text("Close"),
        onPressed: () {
          Navigator.of(context).pop(false);
        },
      ),
      TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ),
    ],
  );
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
