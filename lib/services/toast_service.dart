import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastService {
  static void show(String msg, Color color) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void error(String msg) {
    ToastService.show(msg, Colors.red);
  }
  void info(String msg) {
    ToastService.show(msg, Colors.blue);
  }
  void success(String msg) {
    ToastService.show(msg, Colors.green);
  }
  void warning(String msg) {
    ToastService.show(msg, Colors.orange);
  }
}
