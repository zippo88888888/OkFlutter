import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ok_flutter/base/base.dart';
import 'package:ok_flutter/base/content.dart';
import 'package:ok_flutter/util/bmob_util.dart';
import 'package:ok_flutter/util/system_util.dart';

class RegisterPageView extends StatelessWidget {
  const RegisterPageView();

  @override
  Widget build(BuildContext context) {
    return ToolBar(
      title: "注册",
      body: SingleChildScrollView(
        child: MyRegisterPageView(context),
      ),
    );
  }
}

class MyRegisterPageView extends StatefulWidget {

  final BuildContext __context;
  MyRegisterPageView(this.__context);

  @override
  State<StatefulWidget> createState() => _RegisterPageState(__context);
}

class _RegisterPageState extends State<StatefulWidget> {

  final BuildContext __context;
  _RegisterPageState(this.__context);

  FocusNode _pwdFocusNode = FocusNode();
  FocusNode _ageFocusNode = FocusNode();

  var _nameCanUser = true;
  var _borderColor = Color(0xFFBEBEBE);

  var _name = "";
  var _pwd = "";
  var _age = "18";

  var _obscureText = true;

  /// 检查用户名是否可用
  _checkUserName(String value) {
    _name = value;
    if (value != null && value.length > 0) {
      BmobUtil.selectByName(value, (nameCanUser) {
        _nameCanUser = nameCanUser;
        setState(() {
          if (nameCanUser) {
            // 可用
            _borderColor = Color(0xFFBEBEBE);
          } else {
            _borderColor = Content.red;
          }
        });
      });
    }
  }

  /// 注册
  _startRegister() {
    if (!_nameCanUser) {
      SystemUtil.showToast(msg: "该用户名已被占用，请重新输入");
      return;
    }
    if (_name == null || _name.length <= 0) {
      SystemUtil.showToast(msg: "用户名不能为空");
      return;
    }
    if (_pwd == null || _pwd.length <= 0) {
      SystemUtil.showToast(msg: "密码不能为空");
      return;
    }
    if (_age == null || _age.length <= 0) {
      SystemUtil.showToast(msg: "年龄不能为空");
      return;
    }
    var age = int.parse(_age);
    if (age < 18) {
      SystemUtil.showToast(msg: "未成年禁止使用");
      return;
    }
    BmobUtil.register(context, _name, _pwd, age, (registerSuccess) {
      if (registerSuccess) {
        showDialog(
            context: context,
            builder: (_context) => AlertDialog(
                  title: Text('温馨提示'),
                  content: Text(('恭喜帅气的$_name注册成功！')),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text("确定"),
                      onPressed: () {
                        Navigator.of(_context).pop();
                        var resultData = List<String>(2);
                        resultData[0] = _name;
                        resultData[1] = _pwd;
                        Navigator.of(__context).pop(resultData);
                      },
                    ),
                  ],
                ));
      }
    });
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
                color: _borderColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(25)),
          child: TextField(
            maxLines: 1,
            maxLength: 11,
            onChanged: (value) => _checkUserName(value),
            decoration: InputDecoration(
                hintText: "请输入用户名",
                hintStyle: TextStyle(color: Color(0xFFBEBEBE), fontSize: 13),
                labelStyle: TextStyle(color: Color(0xFF000000), fontSize: 13),
                counterText: "",
                border: InputBorder.none),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).requestFocus(_pwdFocusNode),
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
                focusNode: _pwdFocusNode,
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
                textInputAction: TextInputAction.next,
                onEditingComplete: () => FocusScope.of(context).requestFocus(_ageFocusNode),
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
            ),
          ],
        ),
        Container(
          height: 40,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 30),
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFBEBEBE),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(25)),
          child: TextField(
            focusNode: _ageFocusNode,
            maxLines: 1,
            maxLength: 2,
            onChanged: (value) {
              _age = value;
            },
            decoration: InputDecoration(
                hintText: "请输入年龄",
                hintStyle: TextStyle(color: Color(0xFFBEBEBE), fontSize: 13),
                labelStyle: TextStyle(color: Color(0xFF000000), fontSize: 13),
                counterText: "",
                border: InputBorder.none),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
          ),
        ),
        Container(
          height: 40,
          margin: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
          constraints: BoxConstraints(minWidth: double.infinity),
          child: FlatButton(
            onPressed: () => _startRegister(),
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
