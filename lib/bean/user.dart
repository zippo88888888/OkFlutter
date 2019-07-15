import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// 执行命令  flutter packages pub run build_runner build
///
/// 坑一：
/// 如遇到   Error: No pubspec.yaml file found.
///         This command should be run from the root of your Flutter project.
///         Do not run this command from the root of your git clone of Flutter. 这种错误
///
/// 请切换到 该工程目录下 执行命令
///
@JsonSerializable()
class FlutterUser extends BmobObject {
  int userId;
  int userStatus = 1;
  String userIcon;
  String userPwd;
  String userName;
  bool userSex = true;
  int userAge;

  FlutterUser();

  @override
  Map getParams() {
    return toJson();
  }

  factory FlutterUser.fromJson(Map<String,dynamic> json) =>
      _$FlutterUserFromJson(json);

  Map<String,dynamic> toJson() => _$FlutterUserToJson(this);

}


