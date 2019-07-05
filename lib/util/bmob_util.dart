import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:ok_flutter/base/content.dart';
import 'package:ok_flutter/bean/user.dart';
import 'package:ok_flutter/util/system_util.dart';

class BmobUtil {
  /// 登录
  static void login(BuildContext context, String name, String pwd) {
    BmobQuery<FlutterUser> query = BmobQuery();
    query.addWhereEqualTo("userName", name);
    query.addWhereEqualTo("userPwd", pwd);
    query.queryObjects().then((data) {
      var list = data.map((i) => FlutterUser.fromJson(i)).toList();
      if(list != null && list.isNotEmpty) {
        var user = list[0];
        switch(user.userStatus) {
          case Content.noting:
            SystemUtil.showToast(msg: "登录成功！");
            break;
          case Content.adminError:
            SystemUtil.showToast(msg: "当前账号已被管理员冻结，请联系管理员！");
            break;
          case Content.elseError:
          default:
          SystemUtil.showToast(msg: "未知异常，请联系管理员");
            break;
        }
      } else {
        SystemUtil.showToast(msg: "用户名或密码错误！");
      }
    }).catchError((e){
      print(BmobError.convert(e).error);
    });
  }
}
