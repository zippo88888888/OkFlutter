import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ok_flutter/base/content.dart';
import 'package:ok_flutter/bean/news.dart';
import 'package:ok_flutter/util/bmob_util.dart';
import 'package:ok_flutter/util/system_util.dart';

class NewsInfoPageView extends StatelessWidget {
  final FlutterContent _flutterContent;

  NewsInfoPageView(this._flutterContent);

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
            body: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: _NewsInfoView(_flutterContent))));
  }
}

class _NewsInfoView extends StatefulWidget {
  final FlutterContent _flutterContent;

  const _NewsInfoView(this._flutterContent);

  @override
  State<StatefulWidget> createState() => _NewsInfoStateView();
}

class _NewsInfoStateView extends State<_NewsInfoView> {
  static final _bottomHeight = 50.0;

  ScrollController _scrollController;

  double _offset = 0.0;

  String _userName;

  _getUserInfo() {
    BmobUtil.getUserById(context, widget._flutterContent.userId, (userInfo) {
      setState(() {
        _userName = userInfo.userName;
      });
    });
  }

  _scrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      print("滚动消息停止 3");
    } else if (notification is ScrollStartNotification) {
      print("开始滚动  1");
    } else if (notification is UserScrollNotification) {
      print("滚动停止或【手指已停止滑动】 4");
    } else if (notification is ScrollUpdateNotification) {
      print("滚动中 2");
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _offset = _scrollController.offset /
            _scrollController.position.maxScrollExtent *
            (-_bottomHeight);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // https://github.com/flutterchina/flutter-in-action/blob/master/docs/chapter4/stack.md
  @override
  Widget build(BuildContext context) {
    var display = MediaQuery.of(context).size;
    return Stack(
        overflow: Overflow.visible,
        fit: StackFit.expand, // 未定位widget占满Stack整个空间
        alignment: Alignment(-0.0, 1.0),
        children: <Widget>[
          NotificationListener<ScrollNotification>(
            onNotification: (notification) => _scrollNotification(notification),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: Content.defaultPadding,
                        right: Content.defaultPadding,
                        top: 7,
                        bottom: 5),
                    child: Text(
                      widget._flutterContent.newsTitle,
                      style: TextStyle(
                          color: Content.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Content.defaultPadding,
                        right: Content.defaultPadding,
                        bottom: 5),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(_userName ?? "管理员",
                              style: _getItemTextStyle()),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            alignment: Alignment(1.0, 0.0),
                            child: Text(
                              "发布于：${widget._flutterContent.createdAt}",
                              style: _getItemTextStyle(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Content.defaultPadding,
                        right: Content.defaultPadding,
                        bottom: 5),
                    child: Text(widget._flutterContent.newsContent),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            width: display.width,
            bottom: _offset,
            child: Container(
              height: _bottomHeight,
              color: Content.baseColor,
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () =>
                          SystemUtil.showToast(msg: "bilibili( ゜- ゜)つロ 干杯"),
                      child: Text(
                        "收藏",
                        style: Content.defaultTxtStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    width: 0.5,
                    height: 50,
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    color: Content.white,
                  ),
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () =>
                            BmobUtil.clickLike(widget._flutterContent.newsId),
                        child: Text(
                          "点赞",
                          style: Content.defaultTxtStyle,
                          textAlign: TextAlign.center,
                        ),
                      )),
                ],
              ),
            ),
          )
        ]);
  }

  _getItemTextStyle() => TextStyle(fontSize: 13, color: Colors.grey[600]);
}
