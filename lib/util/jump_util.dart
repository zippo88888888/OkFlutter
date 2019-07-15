import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ok_flutter/bean/news.dart';
import 'package:ok_flutter/ui/add_news.dart';
import 'package:ok_flutter/ui/info.dart';
import 'package:ok_flutter/ui/login/login.dart';
import 'package:ok_flutter/ui/login/register.dart';
import 'package:ok_flutter/ui/main.dart';
import 'package:ok_flutter/ui/search.dart';

// TODO 暂时性的
/// https://blog.csdn.net/yuzhiqiang_1993/article/details/89090742
class JumpUtil {
  static _toPage(BuildContext context, Widget widget) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => widget));
  }

  /// 跳转至注册页面
  static jumpToRegisterPage(BuildContext context) {
    _toPage(context, new RegisterPageView());
  }

  /// 跳转至登录页面
  static jumpToLoginPage(BuildContext context) {
    _toPage(context, new LoginPageView());
  }

  // TODO 这样做因为之前没找到对的BuildContext，阿西吧 Flutter里面全叫context，后面再修改吧
  /// 跳转至登录页面
  static jumpToLoginPage2(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(builder: (context) => new LoginPageView()),
            (dismiss) => dismiss == null);
  }

  /// 跳转至首页
  static jumpToMainPage(BuildContext context) {
    _toPage(context, new MainPageView());
  }

  /// 跳转至首页
  static jumpToMainPage2(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(builder: (context) => new MainPageView()),
            (dismiss) => dismiss == null);
  }

  /// 跳转至添加页面
  static jumToAddPage(BuildContext context) {
    _toPage(context, AddNewsView());
  }

  /// 跳转至详情页面
  static jumpToInfoPage(BuildContext context, FlutterContent flutterContent) {
    _toPage(context, NewsInfoPageView(flutterContent));
  }

  /// 跳转至搜索页面
  static jumpToSearchPage(BuildContext context) {
    _toPage(context, SearchPageView());
  }
}
