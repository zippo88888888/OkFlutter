import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ok_flutter/base/content.dart';
import 'package:ok_flutter/bean/history.dart';
import 'package:ok_flutter/bean/hot.dart';
import 'package:ok_flutter/util/bmob_util.dart';
import 'package:ok_flutter/util/db_util.dart';
import 'package:ok_flutter/util/jump_util.dart';
import 'package:ok_flutter/util/system_util.dart';

class SearchPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPageView> {
  var _searchStr = "";

  List<SearchHistoryBean> _historyList = [];
  List<FlutterHotNews> _hotList = [];

  _init() {
    BmobUtil.getHotNews(context, (list) {
      if (list != null && list.length > 0) {
        setState(() {
          _hotList = list;
        });
      } else {
        SystemUtil.showToast(msg: "暂无数据");
      }
    });
    DatabaseHelper.getInstance().findAll((list) {
      if (list != null && list.length > 0) {
        setState(() {
          _historyList = list;
        });
      } else {
        print("暂无历史纪录");
      }
    });
  }

  _search(String searchStr, bool saveDB) {
    if (searchStr == null || searchStr.length <= 0) {
      SystemUtil.showToast(msg: "搜索内容不能为空");
    } else {
      Navigator.of(context).pop();
      JumpUtil.jumpToSearchListPage(context, searchStr, saveDB);
    }
  }

  _clear() {
    if (_historyList == null || _historyList.length <= 0) {
      SystemUtil.showToast(msg: "暂无历史搜索");
      return;
    }
    DatabaseHelper.getInstance().deleteAll((del) {
      if (del) {
        setState(() {
          _historyList.clear();
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

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
              onEditingComplete: () => _search(_searchStr, true)),
        ),
        centerTitle: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _search(_searchStr, true),
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
              height: 50,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(
                  left: Content.defaultPadding, right: Content.defaultPadding),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  Text("历史搜索"),
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                        onTap: () => _clear(),
                        child: SizedBox(
                          width: 15,
                          height: 15,
                          child: Image.asset("assets/images/ic_del.png"),
                        )),
                  )
                ],
              ),
              color: Content.white,
            ),
            Offstage(
              offstage: !(_historyList.length > 0),
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
                  children: _getHistoryListWidget(),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment(-1.0, 0.0),
              height: 50,
              padding: EdgeInsets.only(
                  left: Content.defaultPadding, right: Content.defaultPadding),
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
                children: _getTagListWidget(),
              ),
            ),
            Container(height: 20)
          ],
        ),
      ),
    ));
  }

  List<Widget> _getHistoryListWidget() {
    List<Widget> list = [];
    for (int i = 0; i < _historyList.length; i++) {
      list.add(_getTagWidget(i, _historyList[i].title));
    }
    return list;
  }

  List<Widget> _getTagListWidget() {
    List<Widget> list = [];
    for (int i = 0; i < _hotList.length; i++) {
      list.add(_getTagWidget(i, _hotList[i].hotNewsTitle));
    }
    return list;
  }

  Widget _getTagWidget(int position, String title) {
    return GestureDetector(
      onTap: () => _search(title, false),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
        decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.grey[500]),
            color: Content.white,
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          title,
          style: TextStyle(color: Colors.grey[500], fontSize: 13),
        ),
      ),
    );
  }
}
