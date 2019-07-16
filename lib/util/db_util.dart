import 'dart:io';

import 'package:ok_flutter/bean/history.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final String _DB_NAME = "OkFlutter_DB";
  static final String _TABLE_NAME = "SearchHistory";

  static final String _T_ID = "historyId";
  static final String _TITLE = "title";
  static final String _TIME = "time";

  static final String _CREATE_TABLE_SQL = "CREATE TABLE $_TABLE_NAME "
      "( $_T_ID INTEGER PRIMARY KEY AUTOINCREMENT,  $_TITLE TEXT, $_TIME TEXT )";

  static DatabaseHelper _databaseHelper;
  static String _dbPath;

  static DatabaseHelper _getDBHelpler() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._();
    }
    return _databaseHelper;
  }

  /// 私有构造函数
  DatabaseHelper._();

  factory DatabaseHelper.getInstance() => _getDBHelpler();

  init() {
    _create();
  }

  /// 创建库
  Future<String> _createDB() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, _DB_NAME);

    var dirPath = dirname(path);
    bool hasDB = await new Directory(dirPath).exists();

    if (!hasDB) {
      try {
        await new Directory(dirPath).create(recursive: true);
      } catch (e) {
        print(e);
      }
    } else {
      print("数据库已存在，不需要再次创建");
    }
    return path;
  }

  /// 创建表
  _create() async {
    _dbPath = await _createDB();
    var db = await openDatabase(_dbPath);
    try {
      await db.execute(_CREATE_TABLE_SQL);
      print("表创建成功");
    } catch (e) {
      print("表已经创建，无需再次操作");
    } finally {
      await db.close();
    }
  }

  findAll(Function(List<SearchHistoryBean>) function) async {
    var db = await openDatabase(_dbPath);
    var data = await db.query(_TABLE_NAME);
    var list = data.map((map) => SearchHistoryBean.fromJson(map)).toList();
    function(list);
    db.close();
  }

  saveUpdate(SearchHistoryBean bean) async {
    var db = await openDatabase(_dbPath);
    var resultList = await db
        .query(_TABLE_NAME, where: "$_TITLE = ?", whereArgs: [bean.title]);
    if (resultList == null || resultList.length <= 0) {
      _save(bean, db);
    } else {
      _update(bean, db);
    }
  }

  _save(SearchHistoryBean bean, Database db) async {
    var count = await db.insert(_TABLE_NAME, bean.toJson());
    if (count > 0) {
      print("保存成功");
    }
    await db.close();
  }

  _update(SearchHistoryBean bean, Database db) async {
    var count = await db.update(_TABLE_NAME, bean.toJson(),
        where: "$_TITLE = ?", whereArgs: [bean.title]);
    if (count > 0) {
      print("修改成功");
    }
    await db.close();
  }

  deleteAll(Function(bool) function) async {
    var db = await openDatabase(_dbPath);
    var count = await db.delete(_TABLE_NAME);
    function(count > 0);
    if (count > 0) {
      print("删除成功===>$count");
    }
    await db.close();
  }
}
