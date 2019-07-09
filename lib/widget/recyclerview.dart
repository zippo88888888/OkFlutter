import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ok_flutter/base/content.dart';
import 'package:ok_flutter/bean/news.dart';
import 'package:ok_flutter/util/system_util.dart';

class RecyclerView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecyclerView();
}

class _RecyclerView extends State<RecyclerView> {
  ScrollController _scrollController = ScrollController();
  List<FlutterContent> _datas = [];

  int _pageNo = 1;

  // 是否可以加载更多数据
  bool _canLoadMore = true;

  Future _onRefresh() async {
    await Future.delayed(Duration(seconds: 3), () {
      SystemUtil.showToast(msg: "刷新");
    });
  }

  Future _onLoadMore() async {
    await Future.delayed(Duration(seconds: 3), () {
      _pageNo++;
      if (_pageNo > 4) {
        setState(() {
          _canLoadMore = false;
        });
      } else {
        List<FlutterContent> loadMoreDatas = List();
        for (var i = 0; i < 5; i++) {
          var item = FlutterContent();
          item.newsTitle = "我是加载更多出来的新闻标题${i + 1}";
          loadMoreDatas.add(item);
        }
        setState(() {
          _datas.addAll(loadMoreDatas);
        });
      }

    });
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 10; i++) {
      var item = FlutterContent();
      item.newsTitle = "我是新闻标题${i + 1}";
      _datas.add(item);
    }
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _onLoadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Content.defaultPadding,
          right: Content.defaultPadding,
          top: 5,
          bottom: 5),
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemBuilder: (context, position) => _getItemView(context, position),
          itemCount: _datas.length + 1,
          controller: _scrollController,
        ),
      ),
    );
  }

  Widget _getItemView(BuildContext context, int position) {
    if (position == _datas.length) {
      // 判断最后一个item
      return _getLoadMoreView();
    } else {
      var itemData = _datas[position];
      return Container(
        alignment: Alignment(0.0, 0.0),
        margin: EdgeInsets.only(top: 5, bottom: 5),
        height: 100,
        color: Content.red,
        child: Text(
          itemData.newsTitle,
          style: Content.titleStyle,
        ),
      );
    }
  }

  /// 构造加载更多视图
  Widget _getLoadMoreView() {
    if (_canLoadMore) {
      return Container(
        height: 50,
        color: Colors.green,
        alignment: Alignment(0.0, 0.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 15,
              height: 15,
              child: new CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "正在加载中...",
                style: TextStyle(fontSize: 14, color: Content.black),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 50,
        alignment: Alignment(0.0, 0.0),
        child: Text(
          "已经全部加载完毕了",
          style: TextStyle(fontSize: 14, color: Content.black),
        ),
      );
    }
  }
}
