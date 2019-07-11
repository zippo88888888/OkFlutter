import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ok_flutter/base/content.dart';
import 'package:ok_flutter/bean/news.dart';

class NewsInfoPageView extends StatelessWidget {

  final FlutterContent _flutterContent;
  const NewsInfoPageView(this._flutterContent);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(
          "详情",
          style: Content.titleStyle,
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        child: _NewsInfoView(_flutterContent),
      ),
    ));
  }
}

class _NewsInfoView extends StatefulWidget {

  final FlutterContent _flutterContent;
  const _NewsInfoView(this._flutterContent);

  @override
  State<StatefulWidget> createState() => _NewsInfoStateView();
}

class _NewsInfoStateView extends State<_NewsInfoView> {

  var _title = "";
  var _content = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

      ],
    );
  }
}
