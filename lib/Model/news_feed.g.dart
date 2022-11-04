// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsFeedModel _$NewsFeedModelFromJson(Map<String, dynamic> json) =>
    NewsFeedModel()
      ..newId = json['newId'] as String?
      ..NewsTitle = json['NewsTitle'] as String?
      ..NewsDescription = json['NewsDescription'] as String?
      ..NewsImage = json['NewsImage'] as String?
      ..createdBy = json['createdBy'] as String?
      ..Type = json['Type'] as String?
      ..createdDtm = json['createdDtm'] as String?;

Map<String, dynamic> _$NewsFeedModelToJson(NewsFeedModel instance) =>
    <String, dynamic>{
      'newId': instance.newId,
      'NewsTitle': instance.NewsTitle,
      'NewsDescription': instance.NewsDescription,
      'NewsImage': instance.NewsImage,
      'createdBy': instance.createdBy,
      'Type': instance.Type,
      'createdDtm': instance.createdDtm,
    };
