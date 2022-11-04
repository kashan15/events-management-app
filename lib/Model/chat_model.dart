import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  ChatModel();

  String? message;
  String? type;
  String? content;
  String? userId;
  String? createdAt;
  String? seen;
  String? delivered;

  factory ChatModel.fromJson(Map<String, dynamic> json) => _$ChatModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

}
