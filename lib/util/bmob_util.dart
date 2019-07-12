import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:ok_flutter/base/content.dart';
import 'package:ok_flutter/bean/news.dart';
import 'package:ok_flutter/bean/user.dart';
import 'package:ok_flutter/util/system_util.dart';
import 'package:ok_flutter/util/user_util.dart';

import 'jump_util.dart';

class BmobUtil {
  /// 登录
  static void login(BuildContext context, String name, String pwd,
      [Function(bool) function]) {
    SystemUtil.showLoadingDialog(context: context);
    BmobQuery<FlutterUser> query = BmobQuery();
    query.addWhereEqualTo("userName", name);
    query.addWhereEqualTo("userPwd", pwd);
    query.queryObjects().then((data) {
      var list = data.map((i) => FlutterUser.fromJson(i)).toList();
      if (list != null && list.isNotEmpty) {
        var user = list[0];
        switch (user.userStatus) {
          case Content.noting:
            UserUtil.loginIn(user);
            SystemUtil.showToast(msg: "登录成功！");
            SystemUtil.dismissDialog();
            if (function == null) {
              JumpUtil.jumpToMainPage2(context);
            } else {
              function(true);
            }
            break;
          case Content.adminError:
            if (function != null) function(false);
            SystemUtil.showToast(msg: "当前账号已被管理员冻结，请联系管理员！");
            SystemUtil.dismissDialog();
            break;
          case Content.elseError:
          default:
            if (function != null) function(false);
            SystemUtil.showToast(msg: "未知异常，请联系管理员");
            SystemUtil.dismissDialog();
            break;
        }
      } else {
        if (function != null) function(false);
        SystemUtil.showToast(msg: "用户名或密码错误！");
        SystemUtil.dismissDialog();
      }
    }).catchError((e) {
      if (function != null) function(false);
      print(BmobError.convert(e).error);
      SystemUtil.showToast(msg: "未知异常，请联系管理员");
      SystemUtil.dismissDialog();
    });
  }

  static void selectByName(String name, Function(bool) function) {
    BmobQuery<FlutterUser> query = BmobQuery();
    query.addWhereEqualTo("userName", name);
    query.queryObjects().then((data) {
      var list = data.map((i) => FlutterUser.fromJson(i)).toList();
      if (list != null && list.isNotEmpty) {
        function(false);
        SystemUtil.showToast(msg: "该用户名已被占用，请重新输入");
      } else {
        function(true);
        print("该用户名可以使用");
      }
    }).catchError((e) {
      if (function != null) function(false);
      print(BmobError.convert(e).error);
      SystemUtil.showToast(msg: "未知异常，请联系管理员");
    });
  }

  /// 注册
  static void register(BuildContext context, String name, String pwd, int age,
      [Function(bool) function]) {
    SystemUtil.showLoadingDialog(context: context);
    var flutterUser = FlutterUser();
    flutterUser.userName = name;
    flutterUser.userPwd = pwd;
    flutterUser.userAge = age;
    flutterUser.save().then((savedData) {
      var objectId = savedData.objectId;
      if (objectId != null && objectId.length >= 0) {
        SystemUtil.dismissDialog();
        if (function == null) {
          JumpUtil.jumpToLoginPage2(context);
        } else {
          function(true);
        }
      } else {
        SystemUtil.showToast(msg: "注册失败，请联系管理员");
        SystemUtil.dismissDialog();
      }
    }).catchError((e) {
      print(BmobError.convert(e).error);
      SystemUtil.showToast(msg: "注册失败，请联系管理员");
      SystemUtil.dismissDialog();
    });
  }

  /// 获取新闻数据
  static void getNewsData(int pageNo, String key, bool myself,
      Function(bool, List<FlutterContent>) function) {
    print("查询第$pageNo页的数据");
    BmobQuery<FlutterContent> query = BmobQuery();
    if (key.isNotEmpty) {
      query.addWhereEqualTo("newsTitle", key);
    }
    if (myself) {
      query.addWhereEqualTo("userId", UserUtil.getUserId());
    }
    query.setOrder("-createdAt");
    // 每次查询10条数据
    query.setLimit(Content.page_size);
    query.setSkip((pageNo - 1) * Content.page_size);
    query.queryObjects().then((data) {
      var resultList =
          data.map((item) => FlutterContent.fromJson(item)).toList();
      function(true, resultList);
    }).catchError((e) {
      print(BmobError.convert(e).error);
      function(false, new List<FlutterContent>(0));
    });
  }

  static void addNes(BuildContext context, String title, String content,
      [Function(bool) function]) {
    SystemUtil.showLoadingDialog(context: context);
    var contentBean = FlutterContent();
    contentBean.userId = UserUtil.getUserId();
    contentBean.newsTitle = title;
    contentBean.newsContent = content;
    contentBean.likeCount = 0;
    contentBean.save().then((savedData) {
      var objectId = savedData.objectId;
      if (objectId != null && objectId.length >= 0) {
        if (function == null) {
          SystemUtil.dismissDialog();
          Navigator.pop(context);
        } else {
          function(true);
          SystemUtil.dismissDialog();
        }
      } else {
        SystemUtil.showToast(msg: "发布失败，请联系管理员");
        if (function != null) function(false);
      }
    }).catchError((e) {
      if (function != null) function(false);
      print(BmobError.convert(e).error);
      SystemUtil.showToast(msg: "发布失败，请联系管理员");
      SystemUtil.dismissDialog();
    });
  }

  /// 点赞
  static void clickLike(int newsId) {
    BmobQuery<FlutterContent> query = BmobQuery();
    query.addWhereEqualTo("newsId", newsId);
    query.queryObjects().then((data) {
      var list = data.map((i) => FlutterContent.fromJson(i)).toList();
      if (list != null && list.isNotEmpty) {
        var news = list[0];
        var likeCount = news.likeCount;
        var content = FlutterContent();
        content.objectId = news.objectId;
        content.likeCount = likeCount + 1;
        content.update().then((bmobUpdated) {
          SystemUtil.showToast(msg: "点赞成功");
        }).catchError((e){
          print(BmobError.convert(e).error);
          SystemUtil.showToast(msg: "未知异常，请联系管理员");
        });
      } else {
        SystemUtil.showToast(msg: "未知异常，请联系管理员");
      }
    }).catchError((e) {
      print(BmobError.convert(e).error);
      SystemUtil.showToast(msg: "未知异常，请联系管理员");
    });

  }

  /// 根据用户ID获取用户信息   不连表查询了
  static void getUserById(BuildContext context, int userId,
      Function(FlutterUser) function) {
    BmobQuery<FlutterUser> query = BmobQuery();
    query.addWhereEqualTo("userId", userId);
    query.queryObjects().then((data) {
      var list = data.map((i) => FlutterUser.fromJson(i)).toList();
      if (list != null && list.isNotEmpty) {
        var user = list[0];
        function(user);
      } else {
        function(null);
      }
    }).catchError((e) {
      function(null);
      print(BmobError.convert(e).error);
      SystemUtil.showToast(msg: "未知异常，请联系管理员");
    });
  }
}
