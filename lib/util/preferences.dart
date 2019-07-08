import 'package:shared_preferences/shared_preferences.dart';

/// 类似 Android SharedPreferences
class SPUtil {

  static const _SP_ROOT_KEY = "OKFlutter_SP_KEY_";

  static const SP_KEY_LOGIN = "${_SP_ROOT_KEY}login";
  static const SP_KEY_NAME = "${_SP_ROOT_KEY}userName";
  static const SP_KEY_SEX = "${_SP_ROOT_KEY}userSex";
  static const SP_KEY_ICON = "${_SP_ROOT_KEY}userIcon";
  static const SP_KEY_TIME = "${_SP_ROOT_KEY}userAddTime";

  static save(String key, dynamic value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (value is String) {
      sharedPreferences.setString(key, value);
    } else if (value is int) {
      sharedPreferences.setInt(key, value);
    } else if (value is double) {
      sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      sharedPreferences.setBool(key, value);
    } else {
      sharedPreferences.setString(key, value.toString());
    }
  }

  static Future<dynamic> get(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var value = sharedPreferences.get(key);
    return value;
  }

  static Future<bool> getBoolean(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var value = sharedPreferences.getBool(key);
    return value;
  }

  static Future<String> getString(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var value = sharedPreferences.getString(key);
    return value;
  }

  static Future<int> getInt(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var value = sharedPreferences.getInt(key);
    return value;
  }

  static Future<double> getDouble(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var value = sharedPreferences.getDouble(key);
    return value;
  }

  static remove(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(key);
  }

  static clear() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
