// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendeeModel _$AttendeeModelFromJson(Map<String, dynamic> json) =>
    AttendeeModel()
      ..eventId = json['eventId'] as String?
      ..Id = json['Id'] as String?
      ..UserId = json['UserId'] as String?
      ..fname = json['fname'] as String?
      ..ProfileImage = json['ProfileImage'] as String?
      ..FirebaseUserId = json['FirebaseUserId'] as String?;

Map<String, dynamic> _$AttendeeModelToJson(AttendeeModel instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
          'Id': instance.Id,
      'UserId': instance.UserId,
      'fname': instance.fname,
      'ProfileImage': instance.ProfileImage,
      'FirebaseUserId': instance.FirebaseUserId,
    };
