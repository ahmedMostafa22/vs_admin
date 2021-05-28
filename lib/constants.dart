import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constants {
  static const primaryColor = Color(0xFF6379CD);
  static const secColor = Color(0xFF585858);
  static const double borderRadius = 25.0;

  static showToast(String msg, bool isError) {
    Fluttertoast.showToast(
        msg: msg, backgroundColor: isError ? Colors.red : Colors.green);
  }
}
