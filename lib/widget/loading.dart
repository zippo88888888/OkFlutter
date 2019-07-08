import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ok_flutter/base/content.dart';

/// 类似 Android ProgressDialog
class ProgressDialog extends Dialog {
  final String _title;

  const ProgressDialog(this._title);

  @override
  Widget build(BuildContext context) {
    return new Material(
      type: MaterialType.transparency, // 透明类型
      child: _ProgressDialogView(_title),
    );
  }
}

class _ProgressDialogView extends StatelessWidget {
  final String _title;

  _ProgressDialogView(this._title);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        height: 75,
        padding: EdgeInsets.only(left: 20),
        margin: EdgeInsets.only(left: 20, right: 20),
        constraints: BoxConstraints(minWidth: double.infinity),
        decoration: new ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0)),
            color: Content.white),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 35,
              height: 35,
              child: new CircularProgressIndicator(
                strokeWidth: 3.5,
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(left: 20.0,right: 20.0),
              child: Text(
                _title ?? "请稍后...",
                style: TextStyle(fontSize: 16, color: Content.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
