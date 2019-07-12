import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ok_flutter/base/content.dart';
import 'package:ok_flutter/util/bmob_util.dart';
import 'package:ok_flutter/util/system_util.dart';

class AddNewsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "添加",
            style: Content.titleStyle,
          ),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
        ),
        body: SingleChildScrollView(
          child: _AddNewsContentView(context),
        ),
      ),
    );
  }
}

class _AddNewsContentView extends StatefulWidget {

  final BuildContext __context;
  _AddNewsContentView(this.__context);

  @override
  State<StatefulWidget> createState() => _AddNewsContentStateView();
}

class _AddNewsContentStateView extends State<_AddNewsContentView> {
  var _name = "";
  var _content = "";

  _toAdd() {
    if (_name == null || _name.length <= 0) {
      SystemUtil.showToast(msg: "标题不能为空");
      return;
    }
    if (_content == null || _content.length <= 0) {
      SystemUtil.showToast(msg: "内容不能为空");
      return;
    }
    if (_content.length <= 50) {
      SystemUtil.showToast(msg: "内容不能少于50个字");
      return;
    }
    BmobUtil.addNes(widget.__context, _name, _content, (isSuccess) {
      if (isSuccess) {
        SystemUtil.showToast(msg: "发布成功");
        Navigator.pop(widget.__context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment(0.0, 0.0),
          padding: Content.paddingMargin,
          margin: EdgeInsets.only(top: 20),
          height: 50,
          color: Content.white,
          child: TextField(
            maxLines: 1,
            onChanged: (value) {
              _name = value;
            },
            maxLength: 30,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                hintText: "请输入标题",
                hintStyle: TextStyle(color: Color(0xFFBEBEBE), fontSize: 16),
                labelStyle: TextStyle(
                    color: Content.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                counterText: "",
                border: InputBorder.none),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          color: Content.white,
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.only(left: Content.defaultPadding, right: 5),
          child: TextField(
            autocorrect: true,
            maxLines: 12,
            maxLength: 1000,
            onChanged: (value) {
              _content = value;
            },
            decoration: InputDecoration(
                hintText: "请输入内容（限1000字）",
                hintStyle: TextStyle(color: Color(0xFFBEBEBE), fontSize: 13),
                labelStyle: TextStyle(color: Content.black, fontSize: 13),
                border: InputBorder.none),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
          ),
        ),
        Container(
          height: 10,
          color: Content.white,
          margin: EdgeInsets.only(bottom: 30),
        ),
        Container(
          margin: Content.paddingMargin,
          height: 50,
          constraints: BoxConstraints(minWidth: double.infinity),
          child: FlatButton(
            onPressed: () => _toAdd(),
            child: Text(
              "发布",
            ),
            color: Content.baseColor,
            textColor: Content.white,
            splashColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      ],
    );
  }
}
