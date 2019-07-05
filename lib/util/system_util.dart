import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SystemUtil {
  static void showToast(
      {@required String msg,
      Toast duration = Toast.LENGTH_SHORT,
      ToastGravity toastGravity = ToastGravity.BOTTOM,
      Color backgroundColor = Colors.black54,
      Color textColor = Colors.white}) {

    Fluttertoast.showToast(
        msg: msg,
        toastLength: duration,
        gravity: toastGravity,
        backgroundColor: backgroundColor,
        textColor: textColor);
  }
}
