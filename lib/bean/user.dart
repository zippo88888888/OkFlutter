import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// 执行命令  flutter packages pub run build_runner build
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


