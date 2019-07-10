import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ok_flutter/base/content.dart';
import 'package:ok_flutter/bean/news.dart';
import 'package:ok_flutter/util/bmob_util.dart';
import 'package:ok_flutter/util/system_util.dart';

import 'else_util.dart';

// TODO 封装成通用的  类似Adapter ？？？
class RecyclerView extends StatefulWidget {
  final String title;
  final int position;

  RecyclerView(this.title, this.position);

  @override
  State<StatefulWidget> createState() => _RecyclerView();
}

/// https://juejin.im/post/5b73c3b3f265da27d701473a
class _RecyclerView extends State<RecyclerView> with AutomaticKeepAliveClientMixin  {

  /// TabBarView 保持状态需要 让 TabBarView 的child 继承自 AutomaticKeepAliveClientMixin
  /// 实现 wantKeepAlive 返回true即可让其不会每次切换后 Widget重新绘制
  @override
  bool get wantKeepAlive => true;

  ScrollController _scrollController = ScrollController();
  List<FlutterContent> _datas = [];

  int _pageNo = 1;

  // 是否可以加载更多数据
  bool _canLoadMore = true;

  Future _onRefresh() async {
    _pageNo = 1;
    _canLoadMore = true;
    await Future.delayed(Duration(milliseconds: 300), () {
      BmobUtil.getNewsData(_pageNo, "", widget.position == 1,
          (isSuccess, list) {
        if (isSuccess) {
          if (list != null && list.length > 0) {
            setState(() {
              _canLoadMore = list.length > 9;
              _datas.clear();
              _datas.addAll(list);
            });
          } else {
            setState(() {
              _canLoadMore = false;
              _datas.clear();
            });
          }
        } else {
          SystemUtil.showToast(msg: "加载失败");
          setState(() {
            _canLoadMore = false;
            _datas.clear();
          });
        }
      });
    });
  }

  /// [needJJ]  分页是否需要加
  Future _onLoadMore({bool needJJ = true}) async {
    if (!_canLoadMore) {
      print("不需要再加载更多了");
      return;
    }
    if (needJJ) _pageNo++;
    await Future.delayed(Duration(milliseconds: 300), () {
      BmobUtil.getNewsData(_pageNo, "", widget.position == 1,
          (isSuccess, list) {
        if (isSuccess) {
          if (list != null && list.length > 0) {
            setState(() {
              _datas.addAll(list);
            });
          } else {
            setState(() {
              _canLoadMore = false;
            });
          }
        } else {
          SystemUtil.showToast(msg: "加载失败，正在重试中...");
          _onLoadMore(needJJ: false);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _onRefresh();
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

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Widget _getItemView(BuildContext context, int position) {
    if (position == _datas.length) {
      // 判断最后一个item
      return _getLoadMoreView();
    } else {
      return GestureDetector(
        onTap: () {
          SystemUtil.showToast(msg: "查看详情$position");
        },
        child: Padding(padding: EdgeInsets.only(
            left: Content.defaultPadding,
            right: Content.defaultPadding,
            top: 2,
            bottom: 2),child: Card(elevation: 2.0, child: _bindViewHolder(context, position)),),
      );
    }
  }

  Widget _bindViewHolder(BuildContext context, int position) {
    var itemData = _datas[position];
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        constraints: BoxConstraints(minHeight: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              itemData.newsTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16,
                  color: Content.black,
                  fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.all(2.5),),
            Text(
              itemData.newsContent,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: _getItemTextStyle(),
            ),
            Padding(padding: EdgeInsets.all(2.5),),
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    ElseUtil.getNewsTimeStr(itemData.createdAt),
                    style: _getItemTextStyle(),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment(1.0, 0.0),
                    child: Text(
                      "喜欢：${itemData.likeCount}",
                      style: _getItemTextStyle(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  _getItemTextStyle() => TextStyle(fontSize: 13, color: Colors.grey[600]);

  /// 构造加载更多视图
  Widget _getLoadMoreView() {
    if (_canLoadMore) {
      return Container(
        height: 50,
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
