import 'package:flutter/material.dart';

void showSnackBar({context, message, color}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: color ?? Colors.black,
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  // Find the Scaffold in the Widget tree and use it to show a SnackBar!
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
