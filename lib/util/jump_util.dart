import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ok_flutter/ui/login/login.dart';
import 'package:ok_flutter/ui/login/register.dart';

class JumpUtil {
  /// 跳转至注册页面
  static jumpToRegisterPage(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new RegisterPageView()));
  }

  /// 跳转至登录页面
  static jumpToLoginPage(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new LoginPageView()));
  }

  /// 跳转至登录页面
  static jumpToLoginPage2(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(builder: (context) => new LoginPageView()),
            (dismiss) => dismiss == null);
  }

}
