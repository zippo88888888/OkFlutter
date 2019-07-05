import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class FlutterContent extends BmobObject {
  int newsId;
  int userId;

  String newsTitle;
  int likeCount = 0;
  String newsPic;
  String newsContent;

  FlutterContent();

  @override
  Map getParams() {
    return toJson();
  }

  factory FlutterContent.fromJson(Map<String,dynamic> json) =>
      _$FlutterContentFromJson(json);

  Map<String,dynamic> toJson() => _$FlutterContentToJson(this);
}