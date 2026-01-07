import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupUtils {
  // Static method, so we can call it directly
  static void showToast(String message, {Color backgroundColor = Colors.pink, Color textColor = Colors.white}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }
}
