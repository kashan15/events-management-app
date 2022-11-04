// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventsModel _$EventsModelFromJson(Map<String, dynamic> json) => EventsModel()
  ..fname = json['fname'] as String?
  ..ProfileImage = json['ProfileImage'] as String?
  ..FirebaseUserId = json['FirebaseUserId'] as String?
  ..id = json['id'] as String?
  ..eventId = json['eventId'] as String?
  //
  ..Id = json['Id'] as String?
  //
  ..UserId = json['UserId'] as String?
  //
  // ..userId = json['userId'] as String?
  ..eventType = json['eventType'] as String?
  ..eventName = json['eventName'] as String?
  ..eventDescription = json['eventDescription'] as String?
  ..eventBanner = json['eventBanner'] as String?
  ..department = json['department'] as String?
  ..province = json['province'] as String?
  ..district = json['district'] as String?
  ..location = json['location'] as String?
  ..eventDate = json['eventDate'] as String?
  ..timeFrom = json['timeFrom'] as String?
  ..timeTo = json['timeTo'] as String?
  ..status = json['status'] as String?
  ..createdDtm = json['createdDtm'] as String?;

Map<String, dynamic> _$EventsModelToJson(EventsModel instance) =>
    <String, dynamic>{
      'fname': instance.fname,
      'ProfileImage': instance.ProfileImage,
      'FirebaseUserId': instance.FirebaseUserId,
      'id': instance.id,
      'eventId': instance.eventId,
      'UserId': instance.UserId,
      'eventType': instance.eventType,
      'eventName': instance.eventName,
      'eventDescription': instance.eventDescription,
      'eventBanner': instance.eventBanner,
      'department': instance.department,
      'province': instance.province,
      'district': instance.district,
      'location': instance.location,
      'eventDate': instance.eventDate,
      'timeFrom': instance.timeFrom,
      'timeTo': instance.timeTo,
      'status': instance.status,
      'createdDtm': instance.createdDtm,
    };
