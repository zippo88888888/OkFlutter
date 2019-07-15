
import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hot.g.dart';

@JsonSerializable()
class FlutterHotNews extends BmobObject {

  int hotNewsId;
  String hotNewsTitle;

  @override
  Map getParams() {
    return null;
  }

  FlutterHotNews();

  factory FlutterHotNews.fromJson(Map<String,dynamic> json) =>
      _$FlutterHotNewsFromJson(json);

  Map<String,dynamic> toJson() => _$FlutterHotNewsToJson(this);

}