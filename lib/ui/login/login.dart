import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ok_flutter/base/content.dart';
import 'package:ok_flutter/util/bmob_util.dart';
import 'package:ok_flutter/util/jump_util.dart';
import 'package:ok_flutter/util/system_util.dart';

class LoginPageView extends StatelessWidget {
  const LoginPageView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(
          "登录",
          style: Content.titleStyle,
        ),
        centerTitle: true,
        backgroundColor: Content.baseColor,
      ),
      body: SingleChildScrollView(
        child: _MyLoginPageView(),
      ),
    ));
  }
}

class _MyLoginPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<StatefulWidget> {
  // 变量保存数据
  var _name = "";
  var _pwd = "";

  var _obscureText = true;

  // 控制器
  final TextEditingController nameController = new TextEditingController();

  // 初始化数据
  initParams() {
    _name = "好大一个月";
    nameController.value = TextEditingValue(text: _name);
  }

  @override
  void initState() {
    super.initState();
    initParams();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 90,
          height: 90,
          margin: EdgeInsets.only(top: 70, bottom: 70),
          child: Image.asset("assets/images/ic_login_logo.png"),
        ),
        Container(
          height: 40,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFBEBEBE),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(25)),
          child: TextField(
            autocorrect: true,
            maxLines: 1,
            maxLength: 11,
            onChanged: (value) {
              _name = value;
            },
            controller: nameController,
            decoration: InputDecoration(
                hintText: "请输入用户名",
                hintStyle: TextStyle(color: Color(0xFFBEBEBE), fontSize: 13),
                labelStyle: TextStyle(color: Color(0xFF000000), fontSize: 13),
                counterText: "",
                border: InputBorder.none),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
        ),
        Stack(
          alignment: Alignment.centerRight,
          children: <Widget>[
            Container(
              height: 40,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 30, right: 30),
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFBEBEBE),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: TextField(
                autocorrect: true,
                maxLines: 1,
                maxLength: 15,
                onChanged: (value) {
                  _pwd = value;
                },
                decoration: InputDecoration(
                    hintText: "请输入密码",
                    hintStyle:
                        TextStyle(color: Color(0xFFBEBEBE), fontSize: 13),
                    labelStyle:
                        TextStyle(color: Color(0xFF000000), fontSize: 13),
                    counterText: "",
                    border: InputBorder.none),
                keyboardType: TextInputType.emailAddress,
                obscureText: _obscureText,
                textInputAction: TextInputAction.done,
              ),
            ),
            Positioned(
              right: 40,
              child: Container(
                  width: 33,
                  height: 33,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Image.asset("assets/images/ic_login_look_pwd.png"),
                  )),
            )
          ],
        ),
        Container(
          height: 40,
          constraints: BoxConstraints(minWidth: double.infinity),
          margin: EdgeInsets.only(left: 30, right: 30, top: 70),
          child: FlatButton(
            onPressed: () {
              if (_name == null || _name.length <= 0) {
                SystemUtil.showToast(msg: "用户名不能为空");
                return;
              }
              if (_pwd == null || _pwd.length <= 0) {
                SystemUtil.showToast(msg: "密码不能为空");
                return;
              }
              BmobUtil.login(context, _name, _pwd);
            },
            child: Text(
              "登录",
            ),
            color: Content.baseColor,
            textColor: Colors.white,
            splashColor: Colors.grey,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          ),
        ),
        Container(
          height: 40,
          margin: EdgeInsets.only(left: 30, right: 30, top: 10),
          constraints: BoxConstraints(minWidth: double.infinity),
          child: FlatButton(
            onPressed: () {
              JumpUtil.jumpToRegisterPage(context);
            },
            child: Text(
              "注册",
            ),
            color: Colors.white,
            textColor: Content.baseColor,
            splashColor: Colors.grey,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(color: Content.baseColor, width: 0.5)),
          ),
        ),
      ],
    );
  }
}
