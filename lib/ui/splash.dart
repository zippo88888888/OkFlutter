import 'dart:async';

import 'package:data_plugin/bmob/bmob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ok_flutter/base/content.dart';
import 'package:ok_flutter/util/jump_util.dart';

import 'login/register.dart';

void main() {
  Bmob.init(Content.appId, Content.apiKey);
  runApp(SplashPageView());
}

class SplashPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPageState(),
    );
  }
}

class SplashPageState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<StatefulWidget> {
  Timer _timer;

  _init() {
    if (_timer == null) {
      _timer = Timer(Duration(milliseconds: 2500), () {
        JumpUtil.jumpToLoginPage2(context);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0.0, 0.0),
      color: Content.baseColor,
      child: Text(
        "我是启动页",
        style: Content.titleStyle,
        textDirection: TextDirection.ltr,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _timer = null;
  }
}
