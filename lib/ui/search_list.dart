import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ok_flutter/base/base.dart';
import 'package:ok_flutter/bean/history.dart';
import 'package:ok_flutter/util/db_util.dart';
import 'package:ok_flutter/widget/recyclerview.dart';

class SearchListPageView extends StatefulWidget {
  final String _title;
  final bool _saveDB;

  const SearchListPageView(this._title, this._saveDB);

  @override
  State<StatefulWidget> createState() => _SearchListPageState();
}

class _SearchListPageState extends State<SearchListPageView> {
  _saveToDB() {
    if (widget._saveDB != null && widget._saveDB) {
      var bean = SearchHistoryBean();
      bean.title = widget._title;
      bean.time = DateTime.now();
      DatabaseHelper.getInstance().saveUpdate(bean);
    }
  }

  @override
  void initState() {
    super.initState();
    _saveToDB();
  }

  @override
  Widget build(BuildContext context) {
    return ToolBar(
      title: "搜索结果",
      body: RecyclerView(widget._title, 0),
    );
  }
}
