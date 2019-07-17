import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ok_flutter/base/base.dart';
import 'package:ok_flutter/base/content.dart';
import 'package:ok_flutter/bean/user.dart';
import 'package:ok_flutter/util/bmob_util.dart';
import 'package:ok_flutter/util/user_util.dart';

class MyPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ToolBar(
      title: "个人信息",
      body: _MyPageView(context),
    );
  }
}

class _MyPageView extends StatefulWidget {
  final BuildContext __context;

  _MyPageView(this.__context);

  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<_MyPageView> {
  FlutterUser _user;

  _init() {
    BmobUtil.getUserInfo((user) {
      setState(() {
        _user = user;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 100,
            margin: EdgeInsets.only(top: 50),
            alignment: Alignment(0.0, 0.0),
            child: SizedBox(
              height: 60,
              width: 60,
              child: CircleAvatar(
                backgroundImage: AssetImage(Content.userIcon1),
              ),
            ),
          ),
          Text(
            _user?.userName ?? UserUtil.getName(),
            style: TextStyle(color: Content.black, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
