import 'package:json_annotation/json_annotation.dart';

part 'news_feed.g.dart';

@JsonSerializable()
class NewsFeedModel {
  NewsFeedModel();

  String? newId;
  String? NewsTitle;
  String? NewsDescription;
  String? NewsImage;
  String? createdBy;
  String? Type;
  String? createdDtm;


  factory NewsFeedModel.fromJson(Map<String, dynamic> json) => _$NewsFeedModelFromJson(json);
  Map<String, dynamic> toJson() => _$NewsFeedModelToJson(this);

}
