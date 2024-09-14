import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void showToast(
  String message, {
  Toast? toastLength,
  Color? backgroundColor,
  Color? textColor,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength ?? Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: backgroundColor ?? Colors.redAccent,
    textColor: textColor ?? Colors.white,
  );
}
