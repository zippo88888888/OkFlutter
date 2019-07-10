import 'package:ok_flutter/base/content.dart';
import 'package:ok_flutter/bean/user.dart';
import 'package:ok_flutter/util/preferences.dart';

class UserUtil {
  static loginIn(FlutterUser user) {
    SPUtil.save(SPUtil.SP_KEY_LOGIN, true);
    _saveUserData(user);
  }

  static _saveUserData(FlutterUser user) {
    SPUtil.save(SPUtil.SP_KEY_ID, user.userId);
    SPUtil.save(SPUtil.SP_KEY_NAME, user.userName);
    SPUtil.save(SPUtil.SP_KEY_ICON, user.userIcon);
    SPUtil.save(SPUtil.SP_KEY_SEX, user.userSex);
    SPUtil.save(SPUtil.SP_KEY_TIME, user.createdAt);
  }

  static bool isLogin() => SPUtil.get(SPUtil.SP_KEY_LOGIN, false) as bool;

  static int getUserId() => SPUtil.get(SPUtil.SP_KEY_ID, 1) as int;

  static bool getSex() => SPUtil.get(SPUtil.SP_KEY_SEX, true) as bool;

  static String getTime() => SPUtil.get(SPUtil.SP_KEY_TIME, "") as String;

  static String getName() => SPUtil.get(SPUtil.SP_KEY_NAME, "") as String;

  static String getIcon() => SPUtil.get(SPUtil.SP_KEY_ICON, "") as String;

  static loginOut([Function function]) {
    SPUtil.clear();
    if (function != null) {
      function(true);
    }
  }
}
