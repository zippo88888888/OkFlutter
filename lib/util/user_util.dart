import 'package:ok_flutter/base/content.dart';
import 'package:ok_flutter/bean/user.dart';
import 'package:ok_flutter/util/preferences.dart';

class UserUtil {
  static loginIn(FlutterUser user) {
    SPUtil.save(SPUtil.SP_KEY_LOGIN, true);
    _saveUserData(user);
  }

  static _saveUserData(FlutterUser user) {
    SPUtil.save(SPUtil.SP_KEY_NAME, user.userName);
    SPUtil.save(SPUtil.SP_KEY_ICON, user.userIcon);
    SPUtil.save(SPUtil.SP_KEY_SEX, user.userSex);
    SPUtil.save(SPUtil.SP_KEY_TIME, user.createdAt);
  }

  static isLogin(Function function) {
    SPUtil.get(SPUtil.SP_KEY_LOGIN)
        .then((isLogin) => function(isLogin as bool));
  }

  static getSex(Function function) {
    SPUtil.get(SPUtil.SP_KEY_SEX).then((sex) => function(sex as bool));
  }

  static getTime(Function function) {
    SPUtil.get(SPUtil.SP_KEY_TIME).then((value) => function(value.toString()));
  }

  static getName(Function function) {
    SPUtil.get(SPUtil.SP_KEY_NAME).then((value) => function(value.toString()));
  }

  static getIcon(Function function) {
    SPUtil.get(SPUtil.SP_KEY_ICON).then((value) => function(value.toString()));
  }

  static loginOut([Function function]) {
    SPUtil.clear();
    if (function != null) {
      function(true);
    }
  }
}
