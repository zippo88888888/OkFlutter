import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ok_flutter/base/content.dart';
import 'package:ok_flutter/util/system_util.dart';

class SearchPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPageView> {
  var _searchStr = "";
  var _showHistoryView = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Container(
          height: 35,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              color: Content.white, borderRadius: BorderRadius.circular(25)),
          child: TextField(
            autocorrect: true,
            maxLines: 1,
            maxLength: 50,
            onChanged: (value) {
              _searchStr = value;
            },
            style: TextStyle(color: Content.black, fontSize: 14),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 1),
                hintText: "请输入标题",
                hintStyle: TextStyle(color: Color(0xFFBEBEBE), fontSize: 14),
                counterText: "",
                border: InputBorder.none),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => SystemUtil.showToast(msg: "开始搜索"),
            color: Content.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(
                  top: Content.defaultPadding,
                  bottom: Content.defaultPadding,
                  left: Content.defaultPadding,
                  right: Content.defaultPadding),
              child: Text(
                "搜索历史",
              ),
              color: Content.white,
            ),
            Offstage(
              offstage: _showHistoryView,
              child: Container(
                margin: EdgeInsets.only(bottom: 1),
                padding: EdgeInsets.only(
                    top: Content.defaultPadding,
                    bottom: Content.defaultPadding,
                    left: Content.defaultPadding,
                    right: Content.defaultPadding),
                color: Content.white,
                width: double.infinity,
                child: Wrap(
                  spacing: 25.0,
                  runSpacing: 10.0,
                  alignment: WrapAlignment.start,
                  children: <Widget>[
                    Text("标签一"),
                    Text("标签一"),
                    Text("标签一"),
                    Text("标签一"),
                    Text("标签一"),
                    Text("标签一"),
                    Text("标签一"),
                    Text("标签一"),
                    Text("标签一"),
                    Text("标签一"),
                    Text("标签一"),
                    Text("标签一"),
                    Text("标签一"),
                    Text("标签一"),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  top: Content.defaultPadding,
                  bottom: Content.defaultPadding,
                  left: Content.defaultPadding,
                  right: Content.defaultPadding),
              child: Text(
                "热门搜索",
              ),
              color: Content.white,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(
                  top: Content.defaultPadding,
                  bottom: Content.defaultPadding,
                  left: Content.defaultPadding,
                  right: Content.defaultPadding),
              color: Content.white,
              width: double.infinity,
              child: Wrap(
                spacing: 25.0,
                runSpacing: 10.0,
                alignment: WrapAlignment.start,
                children: <Widget>[
                  _getTagWidget(1),
                  _getTagWidget(10),
                  _getTagWidget(100),
                  _getTagWidget(1000),
                  _getTagWidget(10000),
                  _getTagWidget(100000),
                  _getTagWidget(1000000),
                  _getTagWidget(100000),
                  _getTagWidget(10000),
                  _getTagWidget(1000),
                  _getTagWidget(100),
                  _getTagWidget(10),
                  _getTagWidget(1),
                  _getTagWidget(1),
                  _getTagWidget(10),
                  _getTagWidget(100),
                  _getTagWidget(1000),
                  _getTagWidget(10000),
                  _getTagWidget(100000),
                  _getTagWidget(1000000),
                  _getTagWidget(100000),
                  _getTagWidget(10000),
                  _getTagWidget(1000),
                  _getTagWidget(100),
                  _getTagWidget(10),
                  _getTagWidget(1),
                ],
              ),
            ),
            Container(height: 20)
          ],
        ),
      ),
    ));
  }

  Widget _getTagWidget(int position) {
    return GestureDetector(
      onTap: () {
        SystemUtil.showToast(msg: "item$position");
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
        decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.grey[500]),
            color: Content.white,
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          "我是item$position",
          style: TextStyle(color: Colors.grey[500], fontSize: 13),
        ),
      ),
    );
  }
}
