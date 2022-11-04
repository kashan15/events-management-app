// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel()
  ..message = json['message'] as String?
  ..type = json['type'] as String?
  ..content = json['content'] as String?
  ..userId = json['userId'] as String?
  ..createdAt = json['createdAt'] as String?
  ..seen = json['seen'] as String?
  ..delivered = json['delivered'] as String?;

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'message': instance.message,
      'type': instance.type,
      'content': instance.content,
      'userId': instance.userId,
      'createdAt': instance.createdAt,
      'seen': instance.seen,
      'delivered': instance.delivered,
    };
