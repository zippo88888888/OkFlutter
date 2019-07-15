
import 'package:json_annotation/json_annotation.dart';

part 'history.g.dart';

@JsonSerializable()
class SearchHistoryBean {

  String title;
  DateTime time;

  SearchHistoryBean();

  factory SearchHistoryBean.fromJson(Map<String,dynamic> json) =>
      _$SearchHistoryBeanFromJson(json);

  Map<String,dynamic> toJson() => _$SearchHistoryBeanToJson(this);

}