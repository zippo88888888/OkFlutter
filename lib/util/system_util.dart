import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ok_flutter/widget/loading.dart';

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

  static var _isShowDialog = false;
  // TODO 这样做会不会有内存泄漏了？
  static BuildContext _context;

  static void showLoadingDialog(
      {@required BuildContext context, String title}) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          _context = context;
          _isShowDialog = true;
          return ProgressDialog(title);
        });
  }

  static void dismissDialog() {
    if (_isShowDialog && _context != null) {
      Navigator.of(_context).pop(); // 关闭对话框
      _isShowDialog = false;
      _context = null;
    } else {
      print("dialog 未显示");
    }
  }
}
