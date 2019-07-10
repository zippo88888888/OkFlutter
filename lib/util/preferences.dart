import 'package:shared_preferences/shared_preferences.dart';

/// 类似 Android SharedPreferences
class SPUtil {
  static SharedPreferences _sharedPreferences;

  static initSharedPreferences() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
  }

  static const _SP_ROOT_KEY = "OKFlutter_SP_KEY_";

  static const SP_KEY_LOGIN = "${_SP_ROOT_KEY}login";
  static const SP_KEY_ID = "${_SP_ROOT_KEY}userId";
  static const SP_KEY_NAME = "${_SP_ROOT_KEY}userName";
  static const SP_KEY_SEX = "${_SP_ROOT_KEY}userSex";
  static const SP_KEY_ICON = "${_SP_ROOT_KEY}userIcon";
  static const SP_KEY_TIME = "${_SP_ROOT_KEY}userAddTime";

  static dynamic get(String key, dynamic defaultValue) {
    var value = _sharedPreferences.get(key);
    if (value == null) {
      return defaultValue;
    } else {
      return value;
    }
  }

  static save(String key, dynamic value) {
    if (value is String) {
      _sharedPreferences.setString(key, value);
    } else if (value is int) {
      _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      _sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      _sharedPreferences.setBool(key, value);
    } else {
      _sharedPreferences.setString(key, value.toString());
    }
  }

  static remove(String key) {
    _sharedPreferences.remove(key);
  }

  static clear() {
    _sharedPreferences.clear();
  }
}
